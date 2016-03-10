require "spec_helper"
describe "Task creation process", type: :feature do
  it "creates a task" do
    visit "/"
    click_link_or_button "New Task"
    expect(page).to have_content "Create Task"
    expect(current_path).to eq("/tasks/new")

    fill_in "Title", with: "Scuba Diving"
    fill_in "Description", with: "Go to the deepest Ocean"
    find("input[type='submit']").click

    expect(page).to have_content "Create Task"
  end
end
