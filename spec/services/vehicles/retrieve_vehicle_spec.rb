require "active_support/all"
require "spec_helper"
require_relative "../../../lib/fleetio/client"
require_relative "../../../app/services/vehicles/retrieve_vehicle"

describe Vehicles::RetrieveVehicle do
  subject(:retrieve_vehicle) { described_class }

  let(:fleetio_api) { class_double(Fleetio::Client, vehicle_info_for: response) }
  let(:response) { instance_double(Fleetio::Client::Response, success: true, body: {id: -1, model: "F250"}) }
  let(:repo) { double :vehicles_repository, find_by: nil }
  let(:vin) { "1FTEW1EF1GFA94517" }

  describe ".with" do
    context "when a vehicle exist in the cache" do
      it "returns the cached vehicle" do
        allow(repo).to receive(:find_by).with(vin: vin) { described_class::Vehicle.new }
        retrieve_vehicle.with(vin: vin, fleetio: fleetio_api,
                              vehicles_repository: repo)

        expect(fleetio_api).not_to have_received(:vehicle_info_for)
      end
    end

    context "when passing a blank vin" do
      let(:vin) { nil }

      it "raise error invalid vin" do
        expect {
          retrieve_vehicle.with(vin: vin, fleetio: fleetio_api,
                                vehicles_repository: repo)
        }.to raise_error(described_class::InvalidVin)
      end
    end

    context "when passing a vin" do
      it "returns a vehicle information" do
        expect(retrieve_vehicle.with(vin: vin,
                                     fleetio: fleetio_api,
                                     vehicles_repository: repo).model).to eql "F250"
      end
    end
  end
end
