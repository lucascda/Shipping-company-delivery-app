class ChangeWeightFromIntegerToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :shipping_prices, :bottom_weight, :float
    change_column :shipping_prices, :upper_weight, :float
  end
end
