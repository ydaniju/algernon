require "gilgamesh/version"

module Gilgamesh
  class Application
    def call(env)
      [200, { "Content-Type" => "text/html" }, ["Hello"]]
    end
  end
end
