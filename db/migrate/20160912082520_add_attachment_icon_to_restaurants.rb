class AddAttachmentIconToRestaurants < ActiveRecord::Migration
  def self.up
    change_table :restaurants do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :restaurants, :icon
  end
end
