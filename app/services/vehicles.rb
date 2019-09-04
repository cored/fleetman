module Vehicles
  NotFound = Class.new(StandardError)

  def self.retrieve_vehicle(vin, vehicle_klass = Vehicle)
    vehicle_klass.by_vin(vin)
  rescue NotFound
    vehicle = RetrieveVehicle.with(vin: vin)
    vehicle_klass.save_vehicle(vehicle)
  end
end
