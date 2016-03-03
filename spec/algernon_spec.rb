require "spec_helper"

describe Algernon do
  include Rack::Test::Methods

  def app
    Algernon::Application.new
  end

  it "returns a list of all my tasks" do
    get "/tasks"
    expect(last_response).to be_ok
    todos = ["complete Algernon", "pray", "Stay happy"]
    expect(last_response.body).to eq(todos.to_s)
  end

  it "returns first item in my tasks" do
    get "/tasks/first"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("complete Algernon")
  end

  it "can respond to post request" do
    post "/tasks"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Post nothing")
  end

  it "can respond to put request" do
    put "/tasks"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Put complete Algernon")
  end

  it "can respond to delete request" do
    delete "/tasks"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Delete complete Algernon")
  end

  it "Application not to be null" do
    expect(app).not_to be nil
  end

  it "has a version number" do
    expect(Algernon::VERSION).not_to be nil
  end
end
