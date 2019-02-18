class CreateWares < ActiveRecord::Migration
  def change
    create_table :wares do |t|
      t.string :title,  null: false, default: ""
      t.float :price,  null: false, default: 0 
      t.float :citrine_count,  null: false, default: 0 
      t.float :freight,  null: false, default: 0 
      t.text :description
      t.string :category,  null: false, default: ""
      t.string :brand,  null: false, default: ""
      t.integer :status,  null: false, default: 0 

      t.timestamps null: false
    end
  end
end
