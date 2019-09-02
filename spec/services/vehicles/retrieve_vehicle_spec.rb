require "active_support/all"
require "spec_helper"
require_relative "../../../lib/fleetio/client"
require_relative "../../../app/services/vehicles/retrieve_vehicle"

describe Vehicles::RetrieveVehicle do
  subject(:retrieve_vehicle) { described_class }

  let(:fleetio_api) { class_double(Fleetio::Client, vehicle_info_for: response) }
  let(:vin) { "1FTEW1EF1GFA94517" }
  let(:vehicle) { OpenStruct.new(model: "F250") }
  let(:response) { instance_double(Fleetio::Client::Response, success?: true, data: vehicle) }

  describe ".with" do
    it "returns a vehicle information" do
      expect(retrieve_vehicle.with(vin: vin, fleetio: fleetio_api).model).to eql "F250"
    end

    context "when passing a blank vin" do
      let(:vin) { nil }

      it "raise error invalid vin" do
        expect {
          retrieve_vehicle.with(vin: vin, fleetio: fleetio_api)
        }.to raise_error(described_class::InvalidVin)
      end
    end
  end
end
