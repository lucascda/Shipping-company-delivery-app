class AddDefaultStatusToOrderService < ActiveRecord::Migration[7.0]
  def change
    change_column :order_services, :order_status, :integer, default: 0
    change_column :order_services, :accepted_status, :integer, default: 0
  end
end
