require "spec_helper"

describe Algernon do
  it "has a version number" do
    expect(Algernon::VERSION).not_to be nil
  end

  it "has a call method with an array" do
    expect(Algernon::Application.new.call("").class).to eq Array
  end
end
