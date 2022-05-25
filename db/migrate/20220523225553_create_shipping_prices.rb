class CreateShippingPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_prices do |t|
      t.float :bottom_volume
      t.float :upper_volume
      t.integer :bottom_weight
      t.integer :upper_weight
      t.float :price_per_km
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
