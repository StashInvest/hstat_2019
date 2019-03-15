require 'sinatra'
require 'json'
require 'active_record'
require 'sqlite3'

=begin
    rvm install 2.5.0
    rvm use 2.5.0
    gem install bundler
    bundle install
=end

class App < Sinatra::Base

    ActiveRecord::Base.establish_connection(
        adapter:  'sqlite3',
        database: 'app.db'
    )

    get "/players" do
        @players = []

        erb :players
    end

end