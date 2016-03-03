require "spec_helper"

module Algernon
  module Routes
    class Router
      attr_reader :route_info

      def draw(&block)
        instance_eval(&block)
        self
      end
    end
  end
end

describe Algernon::Routes::Router do
  def draw(&block)
    router = Algernon::Routes::Router.new
    router.draw(&block).route_info
  end

  def route(regex, placeholders, controller, action, path)
    pattern = [regex, placeholders]
    { path: path, match: pattern, class_and_method: [controller, action] }
  end

  context "endpoints" do
    context "get '/todos', to: 'todos#index'" do
      def endpoint
        draw { get "/todos", to: "todos#index" }
      end

      route_info = { path: "/todos",
                     match: [%r{^/todos$}, []],
                     class_and_method: ["TodosController", :index]
                   }
      it { expect(endpoint).to eq route_info }
    end
  end

  context "get '/photos/:id', to: 'photos#show'" do
    def endpoint
      draw { get "/photos/:id", to: "photos#show" }
    end

    route_info = { path: "/photos/:id",
                   match: [%r{^/photos/(?<id>[^/?#]+)$}, ["id"]],
                   class_and_method: ["PhotosController", :show]
                 }

    it { expect(endpoint).to eq route_info }
  end

  context "get '/photos/:id/edit', to: 'photos#edit'" do
    def endpoint
      draw { get "/photos/:id/edit", to: "photos#edit" }
    end

    regex = %r{^/photos/(?<id>[^/?#]+)/edit$}
    route_info = { path: "/photos/:id/edit",
                   match: [regex, ["id"]],
                   class_and_method: ["PhotosController", :edit]
                 }

    it { expect(endpoint).to eq route_info }
  end

  context "get 'album/:album_id/photos/:photo_id', to: 'photos#album_photo'" do
    def endpoint
      draw { get "/album/:album_id/photos/:photo_id", to: "photos#album_photo" }
    end

    regex = %r{^/album/(?<album_id>[^/?#]+)/photos/(?<photo_id>[^/?#]+)$}
    route_info = { path: "/album/:album_id/photos/:photo_id",
                   match: [regex, %w(album_id photo_id)],
                   class_and_method: ["PhotosController", :album_photo]
                 }

    it { expect(endpoint).to eq route_info }
  end
end
