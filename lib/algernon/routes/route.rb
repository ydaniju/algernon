module Algernon
  module Route
    def root(target)
      get("/", to: target)
    end

    def resources(controller, options = {})
      actions = detect_action(options)

      # rubocop:disable Metrics/LineLength
      get("/#{controller}", to: "#{controller}#index") if actions.include?(:index)
      get("/#{controller}/new", to: "#{controller}#new") if actions.include?(:new)
      post("/#{controller}", to: "#{controller}#create") if actions.include?(:create)
      get("/#{controller}/:id", to: "#{controller}#show") if actions.include?(:show)
      get("/#{controller}/:id/edit", to: "#{controller}#edit") if actions.include?(:edit)
      put("/#{controller}/:id", to: "#{controller}#update") if actions.include?(:update)
      patch("/#{controller}/:id", to: "#{controller}#update") if actions.include?(:update)
      delete("/#{controller}/:id", to: "#{controller}#destroy") if actions.include?(:destroy)
      # rubocop:enable Metrics/LineLength
    end

    def detect_action(options)
      actions = [:index, :new, :create, :show, :edit, :update, :destroy]
      actions -= options[:except] if options.key?(:except)
      actions &= options[:only] if options.key?(:only)
      actions
    end
  end
end
