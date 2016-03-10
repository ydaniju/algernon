require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)

require "algernon"
require "capybara/poltergeist"
require "rack"
require "capybara/rspec"

RSpec.shared_context type: :feature do
  Capybara.javascript_driver = :poltergeist
  before(:all) do
    app = Rack::Builder.parse_file(
      "#{__dir__}/integration/lapis_todo/config.ru"
    ).first
    Capybara.app = app
  end

  after(:all) do
    Task::DB.execute("DROP TABLE IF EXISTS tasks")
    Task.create_table
  end
end
