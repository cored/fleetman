require "rails_helper"

feature "User view all cached vehicles" do
  scenario "Successfully" do
    Vehicle.save_vehicle(OpenStruct.new(vin: "VIN1", id: 1))
    Vehicle.save_vehicle(OpenStruct.new(vin: "VIN2", id: 2))

    visit vehicles_path

    expect(page).to have_css "h2", text: "VIN1"
    expect(page).to have_css "h2", text: "VIN2"
  end

  scenario "No vehicles cached" do
    visit vehicles_path

    expect(page).to have_css "h2", text: "There are no vehicles cached just yet, please retrieve some"
  end
end
