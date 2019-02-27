class AddLevelToCitrines < ActiveRecord::Migration
  def change
    add_column :citrines, :level, :string, :default => Setting.levels.bronze
  end
end
