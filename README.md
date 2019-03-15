# HSTAT 2019

### Description

This is a repo for the HSTAT students visiting Stash! We're building a small Sinatra app that handles requests to [create, read, update, and delete](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) records. You'll hear people refer to this as "CRUD".

### Let's get going!

Assuming you're using RVM:

```bash
rvm install 2.5.0
rvm use 2.5.0
```

Then:

```bash
gem install bundler
bundle install
```

Run the script `create_database.rb` to create a new database:

```bash
ruby create_database.rb
```

Then you can connect to it like so:

```bash
sqlite3 app.db

SQLite version 3.19.3 2017-06-27 16:48:08
Enter ".help" for usage hints.
sqlite> .tables
players
sqlite> select * from players;
sqlite> insert into players (name) values ('Dave');
sqlite> insert into players (name) values ('Bob');
sqlite> insert into players (name) values ('Alice');
sqlite> insert into players (name) values ('Sue');
sqlite> select * from players;
1|Dave
2|Bob
3|Alice
4|Sue
sqlite> 

```

Type ctrl + d to exit.

Typing `rackup` should start a server on port 9292. Visit `http://localhost:9292/players` to see the homepage. There's a redirect that sends the "root path" `/` to the `/players` path. These instructions might differ if you're using [Cloud9](https://c9.io/login).

### Persistence

We'll be working with an app that helps us save data. This is a fundamental part of building any application that needs to store the state of the objects within that domain. The objects we'll be working with are "Players" of a fictional game.

### Databases

Engineers have a large number of databases available to store data. Today, we'll be using [SQLite](https://www.sqlite.org/index.html), which is a small, fast relational database. Other databases you could use when building an application are MySQL, PostgreSQL, and MongoDB.

### ORM

ORM stands for "Object-Relational Mapping". We'll be using an ORM called [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html). ActiveRecord is normally a part of the Rails framework, but since Rails is modular, we can use it in other types of Ruby applications.

ActiveRecord has a pretty sweet [query interface](https://guides.rubyonrails.org/active_record_querying.html) that we'll explore.

### Sinatra

To handle the HTTP requests and rendering of data, we'll be using [Sinatra](http://sinatrarb.com/). Sinatra is a DSL for creating Ruby web apps and is pretty lightweight. There's less "magic" than in Rails, so it means you have to do more, but that's part of the fun sometimes!

### Resources

##### CRUD
https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

##### SQLite
https://www.sqlite.org/index.html

##### ActiveRecord
https://guides.rubyonrails.org/active_record_basics.html
https://guides.rubyonrails.org/active_record_querying.html

##### Sinatra
http://sinatrarb.com/


##### Parsing POST params

Assuming the following code in your Sinatra app:

```ruby
post "/foo" do
  content_type :json

  payload    = JSON.parse(request.body.read)
  some_param = payload['xyz']

  { message: "POST request with params: #{some_param}" }.to_json
end
```

You can POST to it like so:

```bash
$ curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST http://localhost:4567/foo -d "{\"xyz\":\"123\"}"
```

You can do it with GET as well!

```ruby
get "/foo" do
  content_type :json

  some_param = params['xyz']

  { message: "GET request with params: #{some_param}" }.to_json
end
```

```bash
$ curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:4567/foo?xyz=123
```

##### ActiveRecord

Make a connection:

```ruby
ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'app.db'
)
```

Then you can interact with a table named `players` by creating a class like this:

```ruby
class Player < ActiveRecord::Base
end
```

##### Miscellaneous Sinatra things

```ruby
get '/json_example' do
  content_type :json

  { message: "It works! #{Player.count}" }.to_json
end

get '/html_example' do
  content_type :html

  erb :html_example
end
```
