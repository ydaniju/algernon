require "spec_helper"
describe "Task lifecycle", type: :feature do
  it "creates, shows, updates and deletes tasks", js: true do
    visit "/tasker"

    title = ["Scuba Diving", "Fly", "Play"]
    description = ["Go to the deepest Ocean", "India Airways", "Football"]

    title.length.times do
      i = 0
      task_creator(title[i], description[i])
      i + 1
    end

    click_link "Edit"

    fill_in "Description", with: "Ethiopian Airways"
    click_link_or_button "Effect Change"

    count = Task.all.length

    expect(count).to eq 3

    visit "/tasks/1"
    click_link "Delete"

    task_2 = Task.find(2)
    task_2.destroy

    Task.destroy_all

    expect(Task.all).to eq []
  end
end
