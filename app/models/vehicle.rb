class Vehicle < ApplicationRecord
  def self.by_vin(vin)
    find_by!(vin: vin)
  rescue ActiveRecord::RecordNotFound
    raise Vehicles::NotFound
  end

  def self.save_vehicle(vehicle)
    create!(external_id: vehicle.id,
            vin: vehicle.vin,
            json: vehicle.to_json)
  end
end
