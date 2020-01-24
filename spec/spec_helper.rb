require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"



DB = PG.connect({:dbname => 'volunteer_tracker'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM projects *;")
    DB.exec("DELETE FROM volunteers *;")
  end
end
