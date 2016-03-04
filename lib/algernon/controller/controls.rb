require "erubis"

module Algernon
  module Controller
    class Controls
      attr_reader :env
      def initialize(env)
        @env = env
      end

      def render(view_name, locals = {})
        filename = File.join("app", "views", "#{view_name}.html.erb")
        template = File.read(filename)
        eruby = Erubis::Eruby.new(template)
        eruby.result(locals.merge(env: env))
      end
    end
  end
end
