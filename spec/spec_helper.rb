require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec("ALTER SEQUENCE volunteers_id_seq RESTART WITH 1;")
    DB.exec('DELETE FROM projects *;')
    DB.exec("ALTER SEQUENCE projects_id_seq RESTART WITH 1;")
  end
end
