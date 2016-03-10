require "spec_helper"
require "unit/helpers/router"

RSpec.describe Algernon::Routes::Router do
  let(:router) { Router.new }

  it "should have a valid factory" do
    expect(router).to be_a(Algernon::Routes::Router)
  end

  it { expect(router.routes).to be_a(Hash) }

  it { expect(router.routes.length).to eq(5) }

  it do
    expect(Router::HTTP_VERBS).to eq(%w(get post put patch delete))
  end

  it { expect(router.has_routes?).to be_truthy }

  it "gets a matching routes for a given path using 'get_match'" do
    path_regex = Regexp.new("^/todos/[a-zA-Z0-9_]+/foo/*$")
    route = Algernon::Routes::Route.new(path_regex, "todos#foo", 2 => "id")

    expect(router.get_match("get", "/todos/23/foo")).to eq(route)
  end
end
