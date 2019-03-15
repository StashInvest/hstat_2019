require "sqlite3"

db = SQLite3::Database.new("app.db")

result = db.execute <<-SQL
  DROP TABLE IF EXISTS players
SQL

if result == []
  puts "dropped players"
end

result = db.execute <<-SQL
  DROP TABLE IF EXISTS scores
SQL

if result == []
  puts "dropped scores"
end

result = db.execute <<-SQL
  CREATE TABLE players (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30)
  );
SQL

if result == []
  puts "created players"
end

result = db.execute <<-SQL
  CREATE TABLE scores (
    value INTEGER,
    player_id INTEGER
  );
SQL

if result == []
  puts "created scores"
end
