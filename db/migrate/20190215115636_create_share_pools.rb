class CreateSharePools < ActiveRecord::Migration
  def change
    create_table :share_pools do |t|
      t.float :today_enter
      t.float :total
      t.float :user_total
      t.float :pay
      t.float :ware_total
      t.float :gross_sale
      t.float :diamond
      t.float :current_total
      t.float :own_tea

      t.timestamps null: false
    end
  end
end
