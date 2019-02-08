class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.float :price
      t.float :count

      t.references :user
      t.timestamps null: false
    end
  end
end
