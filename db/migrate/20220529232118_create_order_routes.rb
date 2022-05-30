class CreateOrderRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :order_routes do |t|
      t.string :coordinates
      t.date :date
      t.time :time
      t.references :order_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
