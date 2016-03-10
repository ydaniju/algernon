require "spec_helper"
describe "Task lifecycle", type: :feature do
  it "creates, shows, updates and deletes tasks", js: true do
    visit "/"
    click_link_or_button "New Task"
    fill_in "Title", with: "Scuba Diving"
    fill_in "Description", with: "Go to the deepest Ocean"
    click_button "Create Task"

    click_link "Edit"

    fill_in "Title", with: "Scuba Diving"
    fill_in "Description", with: "Go to the deepest Ocean"
    click_link_or_button "Effect Change"

    visit "/tasks/1"
    click_link "Delete"
    expect(Task.all).to eq []
  end
end
