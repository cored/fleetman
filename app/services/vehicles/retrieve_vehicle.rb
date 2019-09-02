require "ostruct"
require_relative "../../../lib/fleetio/client"

module Vehicles
  class RetrieveVehicle
    InvalidVin = Class.new(StandardError)

    def self.with(vin:, fleetio: Fleetio::Client)
      raise InvalidVin if vin.blank?
      response = fleetio.vehicle_info_for("vin")
      return response.data if response.success?
    end
  end
end
