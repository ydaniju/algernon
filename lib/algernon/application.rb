require "rack"
require "algernon/controller/dispatcher"
require "algernon/utility/method_override"

module Algernon
  class Application
    attr_reader :request, :verb, :path, :router

    alias_method :routes, :router

    def initialize
      @router = Routing::Router.new
    end

    def call(env)
      env = MethodOverride.apply_to(env)
      @request = Rack::Request.new(env)
      if router.has_routes?
        respond_to_request
      else
        default_response
      end
    end

    def respond_to_request
      route = router.get_match(request.request_method, request.path_info)
      if route
        handler = Dispatcher.new(request, route)
        handler.response
      else
        page_not_found
      end
    end

    def default_response
      Rack::Response.new(
        "<center><b>Algernon::Penny wise, Pound foolish</center>",
        200,
        "Content-Type" => "text/html"
      )
    end

    def page_not_found
      Rack::Response.new(
        "<center><h1>404 Error</h1>Page not found</center>",
        404,
        "Content-Type" => "text/html"
      )
    end

    private :respond_to_request, :default_response, :page_not_found
  end
end
