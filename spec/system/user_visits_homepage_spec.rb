require "rails_helper"

feature "User visits home page", type: :feature do
  scenario "successfully" do
    visit root_path

    expect(page).to have_link "Vehicles"
  end
end
