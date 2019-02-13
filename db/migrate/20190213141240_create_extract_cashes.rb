class CreateExtractCashes < ActiveRecord::Migration
  def change
    create_table :extract_cashes do |t|
      t.float :coin
      t.string :status, null: false, default: "pending"

      t.references :user
      t.timestamps null: false
    end
  end
end
