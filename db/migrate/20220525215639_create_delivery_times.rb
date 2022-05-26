class CreateDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_times do |t|
      t.integer :bottom_distance
      t.integer :upper_distance
      t.integer :working_days
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
