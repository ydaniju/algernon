require "spec_helper"

describe "Utility Methods" do
  context "#snakify" do
    context "Jotters" do
      it { expect("Jotters".snakify).to eq "jotters" }
    end

    context "jotters" do
      it { expect("jotters".snakify).to eq "jotters" }
    end

    context "JOTTERController" do
      it { expect("JOTTERController".snakify).to eq "jotter_controller" }
    end

    context "JotterController" do
      it { expect("JotterController".snakify).to eq "jotter_controller" }
    end
    context "Jotter8Controller" do
      it { expect("Jotter8Controller".snakify).to eq "jotter8_controller" }
    end
    context "LapisTodo::Person" do
      it { expect("LapisTodo::Person".snakify).to eq "lapis_todo/person" }
    end
    context "jottercontroller" do
      it { expect("jottercontroller".snakify).to eq "jottercontroller" }
    end
  end

  context "#camelify" do
    context "jotter_controller" do
      it { expect("jotter_controller".camelify).to eq "JotterController" }
    end
    context "jotter__todo_app" do
      it { expect("jotter__todo_app".camelify).to eq "JotterTodoApp" }
    end
    context "jotter" do
      it { expect("jotter".camelify).to eq "Jotter" }
    end
  end

  context "#constantify" do
    context "`Hash`" do
      it { expect("Hash".constantify).to eq Hash }
    end

    context "`String`" do
      it { expect("String".constantify).to eq String }
    end

    context "`Array`" do
      it { expect("Array".constantify).to eq Array }
    end
  end
end
