class RemoveCoordinatesFromOrderServices < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_services, :coordinates    
  end
end
