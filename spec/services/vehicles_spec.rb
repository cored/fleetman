require "active_support/all"
require_relative "../../app/services/vehicles/retrieve_vehicle"
require_relative "../../app/services/vehicles"

describe Vehicles do
  subject(:repository) { described_class }

  describe ".retrieve_vehicle" do
    let(:vin) { "VINNUMBER" }
    let(:vehicle) { instance_double("Vehicle") }
    let(:vehicle_klass) { class_double("Vehicle") }
    let(:retrieved_vehicle) { OpenStruct.new }

    it "returns cached vehicles if they exist" do
      allow(vehicle_klass).to receive(:by_vin).with("VINNUMBER") { vehicle }
      expect(repository.retrieve_vehicle(vin, vehicle_klass))
        .to eql(vehicle)
    end

    context "when the vehicle is not cache" do
      before do
        allow(vehicle_klass).to receive(:by_vin).with("VINNUMBER")
          .and_raise(described_class::NotFound)
        allow(Vehicles::RetrieveVehicle).to receive(:with).with(vin: vin) { retrieved_vehicle }
        allow(vehicle_klass).to receive(:save_vehicle).with(retrieved_vehicle)
      end

      it "retrieves the vehicle from Fleetio's API" do
        repository.retrieve_vehicle(vin, vehicle_klass)

        expect(Vehicles::RetrieveVehicle).to have_received(:with).with(vin: vin)
      end

      it "saves the vehicle information" do
        repository.retrieve_vehicle(vin, vehicle_klass)

        expect(vehicle_klass).to have_received(:save_vehicle).with(retrieved_vehicle)
      end
    end
  end
end
