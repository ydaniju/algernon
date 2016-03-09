require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../spec", __FILE__)
require "integration/lapis_todo/config/application.rb"
require "rspec"
require "algernon"
require "rack/test"
ENV["RACK_ENV"] = "test"
