class CreateDemands < ActiveRecord::Migration
  def change
    create_table :demands do |t|
      t.float :price, null: false
      t.float :count, null: false
      t.string :status, null: false, default: Setting.demands.enable

      t.references :user
      t.timestamps null: false
    end
  end
end
