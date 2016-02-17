require "spec_helper"

describe Algernon do
  include Rack::Test::Methods

  def app
    Algernon::Application.new
  end

  it "Application not to be null" do
    expect(app).not_to be nil
  end

  # it "Application not to be null" do
  #   env = {}
  #   response = app.call(env)
  #   expect(response.status).to be 200
  # end

  it "has a version number" do
    expect(Algernon::VERSION).not_to be nil
  end
end
