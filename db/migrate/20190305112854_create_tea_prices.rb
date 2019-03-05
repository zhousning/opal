class CreateTeaPrices < ActiveRecord::Migration
  def change
    create_table :tea_prices do |t|
      t.float :price, null: false, default: 0.5

      t.timestamps null: false
    end
  end
end
