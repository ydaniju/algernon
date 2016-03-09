require "spec_helper"
require "unit/helpers/model"

describe Algernon::TableMaker do
  describe "the column builder module methods" do
    describe ".auto_increment" do
      it "returns the 'AUTOINCREMENT' string if the value is true" do
        expect(Model.send(:auto_increment, true)).to eq("AUTOINCREMENT")
      end
    end

    describe ".default" do
      it { expect(Model.send(:default, 99)).to eq("DEFAULT `99`") }
    end

    describe ".nullable" do
      it { expect(Model.send(:nullable, true)).to eq("NULL") }
    end

    describe ".nullable" do
      it { expect(Model.send(:nullable, false)).to eq("NOT NULL") }
    end

    describe ".primary_key" do
      it { expect(Model.send(:primary_key, true)).to eq("PRIMARY KEY") }
    end

    describe ".primary_key" do
      it { expect(Model.send(:primary_key, false)).to eq("") }
    end
  end
end
