class CreateDemands < ActiveRecord::Migration
  def change
    create_table :demands do |t|
      t.float :price, null: false, default: 0
      t.float :count, null: false, default: 0
      t.string :status, null: false, default: Setting.demands.enable

      t.references :user
      t.timestamps null: false
    end
  end
end
