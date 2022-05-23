class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :brand_name
      t.string :model
      t.string :fab_year
      t.integer :max_cap
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
