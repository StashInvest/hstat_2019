require 'sinatra'
require 'json'
require 'active_record'
require 'sqlite3'

# https://guides.rubyonrails.org/active_record_basics.html
# https://guides.rubyonrails.org/active_record_querying.html
# ActiveRecord magic...
class Player < ActiveRecord::Base
end

class App < Sinatra::Base

  # This is important for being able to DELETE!!
  # please see https://stackoverflow.com/a/5169913/2337764
  use Rack::MethodOverride
  # Also check out lines 10-13 of `views/players.erb`

  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'app.db'
  )

  # HTTP GET, this redirects you to "/players" so you have a clean starting point!
  get "/" do
    redirect "/players"
  end

  # HTTP GET, lists all players
  get "/players" do
    @players = Player.all

    erb :players
  end

  # HTTP GET, this renders the page that you can use to create a new player
  get "/player/new" do
    erb :new_player
  end

  # HTTP DELETE, this deletes the player from the db (find, then destroy)
  delete "/player/:id" do
    player = Player.find(params['id'])
    player.destroy

    redirect "/players"
  end

  # HTTP POST, this creates a new player
  post "/player" do
    name = params['name']

    @player = Player.create(name: name)

    redirect "/players"
  end

  # HTTP PATCH, this updates an existing player (name only)
  patch "/player/:id" do
    name   = params['name']
    player = Player.find(params['id'])

    player.name = name

    redirect "/players"
  end

end
