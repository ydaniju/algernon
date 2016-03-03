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
    context "Jotter90Controller" do
      it { expect("Jotter90Controller".snakify).to eq "jotter90_controller" }
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

  context "#pluralize" do
    context "sail" do
      it { expect("sail".pluralize).to eq "sails" }
    end

    context "buzz" do
      it { expect("buzz".pluralize).to eq "buzzes" }
    end

    context "carry" do
      it { expect("carry".pluralize).to eq "carries" }
    end

    context "toy" do
      it { expect("toy".pluralize).to eq "toys" }
    end

    context "dwarf" do
      it { expect("dwarf".pluralize).to eq "dwarves" }
    end

    context "analysis" do
      it { expect("analysis".pluralize).to eq "analyses" }
    end

    context "stadium" do
      it { expect("stadium".pluralize).to eq "stadia" }
    end

    context "criterion" do
      it { expect("criterion".pluralize).to eq "criteria" }
    end

    context "formula" do
      it { expect("formula".pluralize).to eq "formulae" }
    end

    context "locus" do
      it { expect("locus".pluralize).to eq "loci" }
    end

    context "bureau" do
      it { expect("bureau".pluralize).to eq "bureaux" }
    end
  end
end
