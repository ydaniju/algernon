require "erubis"

module Algernon
  module Controller
    class Controls
      attr_reader :env
      def initialize(env)
        @env = env
      end

      def render(view_name, locals = {})
        filename = File.join("app",
                             "views",
                             controller_for_views,
                             "#{view_name}.html.erb"
                            )
        template = File.read(filename)
        eruby = Erubis::Eruby.new(template)
        eruby.result(locals.merge(env: env))
      end

      def controller_for_views
        controller_class = self.class
        controller_class = controller_class.to_s.gsub(/Controller$/, "")
        controller_class.snakify
      end
    end
  end
end
