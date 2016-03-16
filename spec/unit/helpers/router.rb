require "algernon/routing/router"

class Router < Algernon::Routing::Router
  def initialize
    super

    draw do
      get "todos/:id/foo", to: "todos#foo"
      root "todos#index"
      resources :todos
    end
  end
end
