LapisTodoApp.routes.draw do
  get "/tasks", to: "tasks#index"
  get "/tasks/:id", to: "tasks#show"
  post "/tasks", to: "tasks#create"
  put "/tasks/:id", to: "tasks#update"
  patch "/tasks/:id", to: "tasks#patch"
  delete "/tasks/:id", to: "tasks#destroy"
end
