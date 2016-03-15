require "spec_helper"
require "unit/helpers/finder.rb"

RSpec.describe Algernon::Routing::Finder do
  let(:route) do
    Route.new
  end

  it { expect(route.controller).to be_a(Class) }

  it { expect(route.controller_name).to eq("todos_controller") }

  it { expect(route.action).to eq("index") }

  it { expect(route.path_regex).to eq(Regexp.new("/todos/[a-zA-Z0-9_]+")) }

  it { expect(route.url_placeholders).to eq(2 => "id") }

  it { expect(route.get_url_parameters("/todos/45")).to eq("id" => "45") }

  it { expect(route.check_path("/todos/99/six")).to be_truthy }
end
