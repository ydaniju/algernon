module Algernon
  module Routes
    class Route
      attr_reader :class_name, :request, :method
      def initialize(request, class_and_method)
        @class_name, @method = class_and_method
        @request = request
      end

      def controller_class
        class_name.constantize
      end

      def dispatch
        controller_class.new(request).send(method)
      end
    end
  end
end
