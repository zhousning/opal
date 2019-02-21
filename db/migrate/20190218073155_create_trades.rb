class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.float :min, null: false, default: 1 
      t.float :max, null: false, default: 1.2 
      t.float :total_purchase, null: false, default: 0 
      t.float :price, null: false, default: 0 
      t.float :volume, null: false, default: 0 

      t.timestamps null: false
    end
  end
end
