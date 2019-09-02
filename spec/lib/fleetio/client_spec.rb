require "vcr_helper"
require "spec_helper"
require_relative "../../../lib/fleetio/client"

describe Fleetio::Client do
  subject(:fleetio) { described_class }

  let(:valid_vin) { "3FA6P0HD0KR287166" }

  describe ".vehicle_info_for" do
    it "returns a successful response for a valid vin" do
      VCR.use_cassette("vehicles_by_vin") do
        expect(fleetio.vehicle_info_for(valid_vin)).to be_success
      end
    end

    it "returns the vehicles by the provided filter" do
      VCR.use_cassette("vehicles_by_vin") do
        expect(fleetio.vehicle_info_for(valid_vin).data.first.name).to eql "001 TEST"
      end
    end
  end
end
