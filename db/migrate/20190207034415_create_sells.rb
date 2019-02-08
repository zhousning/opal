class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.float :price, null: false, default: 0
      t.float :count, null: false, default: 0
      t.string :status, null: false, default: Setting.sells.enable

      t.references :user
      t.timestamps null: false
    end
  end
end
