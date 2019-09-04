require "rails_helper"

feature "User retrieve cache vehicle information" do
  scenario "successfully" do
    visit new_search_path

    fill_in "q", with: "3FA6P0HD0KR287166"
    click_on "Search"

    expect(page).to have_content "Vehicle"
  end
end
