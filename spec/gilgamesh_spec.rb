require "spec_helper"

describe Gilgamesh do
  it "has a version number" do
    expect(Gilgamesh::VERSION).not_to be nil
  end

  it "has a call method with an array" do
    expect(Gilgamesh::Application.new.call("").class).to eq Array
  end
end
