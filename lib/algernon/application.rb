module Algernon
  class Application
    attr_reader :routes

    def initialize
      @routes = Routes::Router.new
    end

    def call(env)
      @request = Rack::Request.new(env)
      route = finder.locate_route(@request)
      if route
        response = route.dispatch
        return [200, { "Content-Type" => "text/html" }, [response]]
      end
      [404, {}, ["Route not found"]]
    end

    def finder
      @finder ||= Routes::Finder.new(routes.endpoints)
    end
  end
end
