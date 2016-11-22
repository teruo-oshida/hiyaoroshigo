class AbolishFileAttachment < ActiveRecord::Migration
  def self.up
    remove_attachment :sakes, :photo
    remove_attachment :restaurants, :icon
  end

  def self.down
    change_table :sakes do |t|
      t.attachment :photo
    end
    change_table :restaurants do |t|
      t.attachment :icon
    end
  end
end
