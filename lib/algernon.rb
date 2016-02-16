require "algernon/version"

module Algernon
  class Application
    def call(env)
      [200, { "Content-Type" => "text/html" }, ["Hello"]]
    end
  end
end
