require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "algernon"
require "utility/utility"
require "rspec"
require "rack/test"

ENV["RACK_ENV"] = "test"
