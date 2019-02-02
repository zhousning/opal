class CreateTrees < ActiveRecord::Migration
  def change
    create_table :trees do |t|
      t.string :name,              null: false, default: ""
      t.integer :count,            null: false, default: 0 

      t.references :user
      t.timestamps null: false
    end
  end
end
