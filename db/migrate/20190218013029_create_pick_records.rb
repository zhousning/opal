class CreatePickRecords < ActiveRecord::Migration
  def change
    create_table :pick_records do |t|
      t.float :number

      t.references :user
      t.timestamps null: false
    end
  end
end
