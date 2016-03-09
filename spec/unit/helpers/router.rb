require "algernon/routes/router"

class Router < Algernon::Routes::Router
  def initialize
    super

    draw do
      get "todos/:id/foo", to: "todos#foo"
      root "todos#index"
      resources :todos
    end
  end
end
