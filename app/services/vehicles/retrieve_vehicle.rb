module Vehicles
  class RetrieveVehicle
    InvalidVin = Class.new(StandardError)

    Vehicle = Struct.new(:model, keyword_init: true) do
      def self.for(vehicle_response)
        new(vehicle_response.body.slice(:model))
      end
    end
    def self.with(vin:, fleetio: Fleetio::Client, vehicles_repository: Vehicle)
      raise InvalidVin if vin.blank?
      vehicle = vehicles_repository.find_by(vin: vin)
      vehicle = Vehicle.for(fleetio.vehicle_info_for("vin"))  if vehicle.nil?
      vehicle
    end
  end
end
