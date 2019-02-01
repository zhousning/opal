class CreateEnclosures < ActiveRecord::Migration
  def change
    create_table :enclosures do |t|
      t.string :file,  null: false, default: ""

      t.timestamps null: false
    end
  end
end
