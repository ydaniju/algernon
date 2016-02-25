module Algernon
  module Route
    class Router
      def draw(&block)
        instance_eval(&block)
      end

      def get(path, to:)
        path = "/#{path}" unless path[0] = "/"
        class_and_method = controller_and_action(to)
        @route_info = { path: path,
                        match: match_for(path),
                        class_and_method: class_and_method
                      }
        endpoints[:get] << @route_info
      end

      def root(destination)
        get "/", to: destination
      end

      def endpoints
        @endpoints ||= Hash.new { |hash, key| hash[key] = [] }
      end

      private

      def match_for(path)
        placeholders = []
        path = path.gsub(/(:\w+)/) do |match|
          placeholders << match[1..-1].freeze
          "(?<#{placeholders.last}>[^/?#]+)"
        end
        [/^#{path}$/, placeholders]
      end

      def controller_and_action(path)
        controller_path, action = path.split("#")
        controller = "#{controller_path.capitalize}Controller"
        [controller, action.to_sym]
      end
    end
  end
end
