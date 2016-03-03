require "spec_helper"
$LOAD_PATH.unshift File.expand_path("../helpers", __FILE__)

describe "Helpers Methods" do
  context "#const_missing" do
    it "becomes a constant" do
      expect("LapisTodoController".constantify).to eq LapisTodoController
    end

    it { expect("TodoController".constantify).to eq TodoController }

    it { expect("Lasagna".constantify).to eq Lasagna }
  end
end
