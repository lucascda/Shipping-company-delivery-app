class AddProductCodeToOrderService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_services, :product_code, :string    
  end
end
