class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.float :min, null: false, default: 1 
      t.float :max, null: false, default: 1.2 
      t.float :total_purchase, null: false, default: 0 
      t.float :price, null: false, default: 0 
      t.float :volume, null: false, default: 0 

      t.time :start, null: false, default: Setting.trades.start_default 
      t.time :end, null: false, default: Setting.trades.end_default 

      t.timestamps null: false
    end
  end
end
