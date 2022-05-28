class CreateOrderServices < ActiveRecord::Migration[7.0]
  def change
    create_table :order_services do |t|
      t.string :source_adress
      t.string :dest_adress
      t.string :code
      t.float :volume
      t.float :weight
      t.text :coordinates
      t.integer :order_status
      t.integer :accepted_status
      t.references :carrier, null: false, foreign_key: true
      t.references :vehicle, null: true, foreign_key: true

      t.timestamps
    end
  end
end
