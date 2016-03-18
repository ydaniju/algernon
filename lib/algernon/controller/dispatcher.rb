module Algernon
  class Dispatcher
    attr_reader :request, :route, :response

    def initialize(request, route)
      @request = request
      @route = route
      process_request
    end

    private

    def process_request
      params = combine_parameters

      request.instance_variable_set "@params", params

      controller_constant = route.controller
      controller_class = controller_constant.new(request)

      @response = controller_response(controller_class, route.action.to_sym)
    end

    def combine_parameters
      route_url_params = route.get_url_parameters(request.path_info)
      request.params.merge(route_url_params)
    end

    def controller_response(controller, action)
      controller.send(action)

      unless controller.get_response
        controller.render(action)
      end
      controller.get_response
    end
  end
end
