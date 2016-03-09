require "erubis"
require "active_support/core_ext/hash/indifferent_access"

module Algernon
  module Controller
    class Controls
      attr_reader :request
      def initialize(request)
        @request = request
      end

      def get_response
        @response
      end

      def render(view_name, locals = {})
        filename = File.join(APP_ROOT,
                             "app",
                             "views",
                             controller_for_views,
                             "#{view_name}.html.erb"
                            )
        template = File.read(filename)
        parameters = process_view_variables(locals)
        res_body = Erubis::Eruby.new(template).result(parameters)
        response_setter(res_body)
      end

      def process_view_variables(locals)
        hash = {}
        vars = instance_variables
        vars.each { |name| hash[name] = instance_variable_get(name) }

        hash.merge(locals)
      end

      def response_setter(body, status = 200, headers = {})
        @response = Rack::Response.new(body, status, headers)
      end

      def redirect_to(destination)
        response_getter([], 302, "Location" => destination)
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
end
