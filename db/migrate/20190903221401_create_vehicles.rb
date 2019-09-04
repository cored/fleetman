class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :vin, null: false
      t.integer :external_id, null: false
      t.json :json

      t.timestamps
    end
  end
end
