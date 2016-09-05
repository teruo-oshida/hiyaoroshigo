class AddPositionAndEnabledToSakeTemperatures < ActiveRecord::Migration[5.0]
  def change
    add_column :sake_temperatures, :position, :integer
    add_column :sake_temperatures, :enabled, :boolean, null: false, default: true
  end
end
