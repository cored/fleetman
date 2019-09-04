require "rails_helper"

feature "User retrieve cache vehicle information" do
  scenario "successfully" do
    VCR.use_cassette("vehicle_by_vin") do
      visit new_search_path

      fill_in "q", with: "123"
      click_on "Search"

      expect(page).to have_content "Vehicle"
    end
  end
end
