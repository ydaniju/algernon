require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "lapis_todo/config/application.rb"
require "rspec"
require "algernon"
require "rack/test"
ENV["RACK_ENV"] = "test"
