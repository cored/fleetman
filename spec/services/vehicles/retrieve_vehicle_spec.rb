require "active_support/all"
require "spec_helper"
require_relative "../../../app/services/vehicles/retrieve_vehicle"

describe Vehicles::RetrieveVehicle do
  subject(:retrieve_vehicle) { described_class }


  let(:fleetio_api) { double(:fleetio_api, vehicle_info_for: response) }
  let(:response) { double(:response, success: true, body: {id: -1, model: "F250"}) }
  describe ".with" do
    context "when passing a blank vin" do
      let(:vin) { nil }

      it "raise error invalid vin" do
        expect { retrieve_vehicle.with(vin: vin, fleetio: fleetio_api) }
          .to raise_error(described_class::InvalidVin)
      end
    end

    context "when passing a vin" do
      let(:vin) { "1FTEW1EF1GFA94517" }

      it "returns a vehicle information" do
        expect(retrieve_vehicle.with(vin: vin,
                                     fleetio: fleetio_api).model).to eql "F250"
      end
    end
  end
end
