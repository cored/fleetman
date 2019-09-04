require "vcr_helper"
require "spec_helper"
require_relative "../../../lib/fleetio/client"

describe Fleetio::Client do
  subject(:fleetio) { described_class }

  describe ".all_vehicles" do
    it "returns a collection of vehicles"  do
      VCR.use_cassette("vehicles_by_vin") do
        expect(fleetio.all_vehicles).to be_success
      end
    end
  end
end
