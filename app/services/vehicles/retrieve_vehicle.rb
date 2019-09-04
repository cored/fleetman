require "ostruct"
require_relative "../../../lib/fleetio/client"

module Vehicles
  class RetrieveVehicle
    InvalidVin = Class.new(StandardError)

    def self.with(vin:, fleetio: Fleetio::Client)
      raise InvalidVin if vin.blank?
      response = fleetio.all_vehicles
      new(vehicles: response.data).vehicle(vin)
    end

    def initialize(vehicles:)
      @vehicles = vehicles
    end

    def vehicle(vin)
      @vehicle ||= vehicles.find { |vehicle| vehicle.vin == vin }
    end

    private

    attr_reader :vehicles
  end
end
