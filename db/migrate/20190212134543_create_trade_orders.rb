class CreateTradeOrders < ActiveRecord::Migration
  def change
    create_table :trade_orders do |t|
      t.string :number
      t.float :price
      t.string :state,     null: false, default: "opening"
      t.string :name,      null: false
      t.string :phone,     null: false
      t.string :address,   null: false
      t.string :wayno #运单号

      t.references :user
      t.references :ware
      t.timestamps null: false
    end
  end
end
