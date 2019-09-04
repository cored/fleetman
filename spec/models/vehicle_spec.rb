require "rails_helper"

describe Vehicle do
  subject(:model) { described_class }

  let(:external_id) { 763257 }
  let(:vehicle) do
    JSON.parse("{\"vin\": \"XXXXXXXXXXXXXXXXX\",
                 \"id\": \"#{external_id}\",
                 \"account_id\": \"18\"}", object_class: OpenStruct)
  end
  describe ".by_vin" do
    it "returns vehicle if exists by the vin number" do
      model.save_vehicle(vehicle)
      expect(model.by_vin(vehicle.vin).external_id).to eql external_id
    end

    it "raises vehicle not found if the vehicle doesn't exists" do
      expect {
        model.by_vin("blank")
      }.to raise_error(Vehicles::NotFound)
    end
  end

  describe ".save_vehicle" do
    it "stores vehicles" do
      expect {
        model.save_vehicle(vehicle)
      }.to change { model.count }.by 1
    end

    it "stores the whole vehicle json payload" do
      saved_vehicle_payload = JSON.parse(
        model.save_vehicle(vehicle).json,
        object_class: OpenStruct
      ).table

      expect(saved_vehicle_payload).to eql vehicle
    end
  end
end
