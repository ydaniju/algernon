require "tilt/erubis"
require "active_support/core_ext/hash/indifferent_access"

module Algernon
  class BaseController
    attr_reader :request
    def initialize(request)
      @request = request
    end

    def get_response
      @response
    end

    def render(*args)
      response_setter(render_template(*args))
    end

    def render_template(view_name, locals = {})
      filename = File.join(APP_ROOT,
                           "app",
                           "views",
                           controller_for_views,
                           "#{view_name}.html.erb"
                          )
      template = Tilt::ErubisTemplate.new(filename)
      template.render(self, locals)
    end

    def response_setter(body, status = 200, headers = {})
      @response = Rack::Response.new(body, status, headers)
    end

    def redirect_to(destination)
      response_setter([], 302, "Location" => destination)
    end

    def params
      request.params.with_indifferent_access
    end

    def controller_for_views
      controller_class = self.class
      controller_class = controller_class.to_s.gsub(/Controller$/, "")
      controller_class.snakify
    end
  end
end
