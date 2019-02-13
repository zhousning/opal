class CreateTradeOrders < ActiveRecord::Migration
  def change
    create_table :trade_orders do |t|
      t.string :number
      t.float :price
      t.string :state, null: false, default: "opening"
      t.string :name
      t.string :phone
      t.string :address

      t.references :user
      t.references :ware
      t.timestamps null: false
    end
  end
end
