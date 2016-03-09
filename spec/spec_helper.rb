require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)

require "rspec"
require "algernon"
require "rack/test"
ENV["RACK_ENV"] = "test"
RSpec.shared_context type: :feature do
  require "capybara/rspec"

  before(:all) do
    app = Rack::Builder.parse_file(
      "#{__dir__}/integration/lapis_todo/config.ru"
    ).first
    Capybara.app = app
  end
end
