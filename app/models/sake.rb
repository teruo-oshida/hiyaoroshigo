class Sake < ApplicationRecord
  belongs_to :brewery
  has_many :sake_menu_items
  has_many :drinkings
  has_attached_file :photo, :styles => { :medium => "x450", :thumb => "150x150#" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
