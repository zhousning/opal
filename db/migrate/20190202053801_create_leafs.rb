class CreateLeafs < ActiveRecord::Migration
  def change
    create_table :leafs do |t|
      t.integer :pick,            null: false, default: 0 
      t.integer :unpick,          null: false, default: 0 
      t.float :count,             null: false, default: 0 
      t.datetime :pick_time

      t.references :user

      t.timestamps null: false
    end
  end
end
