module Vehicles
  class RetrieveVehicle
    InvalidVin = Class.new(StandardError)

    Vehicle = Struct.new(:model, keyword_init: true) do
      def self.for(vehicle_response)
        new(vehicle_response.body.slice(:model))
      end
    end
    def self.with(vin:, fleetio: Fleetio::Client)
      raise InvalidVin if vin.blank?
      Vehicle.for(fleetio.vehicle_info_for("vin"))
    end
  end
end
