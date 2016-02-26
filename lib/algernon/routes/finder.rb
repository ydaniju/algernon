module Algernon
  module Routes
    class Finder
      def intialize(endpoints)
        @endpoints = endpoints
      end

      def locate_route(request)
        @request = request
        path = request.path_info
        method = request.request_method.downcase.to_sym
        result = @endpoints[method].detect do |endpoint|
          find_path_with_pattern path, endpoint
        end
        return Route.new(@request, result[:class_and_method]) if result
      end

      def find_path_with_pattern(path, endpoint)
        regex, placeholders = endpoint[:pattern]
        if path.match(regex)
          match_data = Regexp.last_match
          placeholders.each do |placeholder|
            @request.update_param(placeholder, match_data[placeholder])
          end
          true
        end
      end
    end
  end
end
