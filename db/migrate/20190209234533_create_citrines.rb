class CreateCitrines < ActiveRecord::Migration
  def change
    create_table :citrines do |t|
      t.float :count, null: false, default: 0
      t.float :total, null: false, default: 0
      t.references :user

      t.timestamps null: false
    end
  end
end
