# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

RESTAURANT_ICON_DIR = File.expand_path("seeds/images/restaurant_icons", __dir__)
SAKE_PHOTO_DIR = File.expand_path("seeds/images/sake_photos", __dir__)

Sake.transaction do
  [
    [1, "ロック（加氷）", nil, false],
    [2, "冷酒", 1, true],
    [3, "常温", 2, true],
    [4, "ぬる燗", nil, false],
    [5, "お燗", 3, true],
    [6, "とびきり燗", nil, false]
  ].each do |id, name, position, enabled|
    st = SakeTemperature.find_or_create_by!(id: id) { |s| s.name = name }
    st.name = name
    st.position = position
    st.enabled = enabled
    st.save!
  end
  mtq2016 = Festival.find_or_create_by!(name: "ShimaneCommunities2016")
  mtq2016.start_at = Time.mktime(2016, 11, 1, 0, 0, 0)
  mtq2016.end_at = Time.mktime(2016, 11, 24, 22, 0, 0)
  mtq2016.save!
  restaurants = [
    ["ホンソゴ", "ホンソゴ", "35.463928", "133.058368", "yu-zan.png", 30]
  ].map { |name, official_name, latitude, longitude, icon_file, capacity|
    File.open(File.join(RESTAURANT_ICON_DIR, icon_file)) { |icon|
      r = Restaurant.find_or_create_by!(name: name)
      r.official_name = official_name
      r.latitude = latitude
      r.longitude = longitude
      r.icon = icon
      r.capacity = capacity
      r.save!
      r
    }
  }
  restaurants.each do |restaurant|
    RestaurantParticipation.find_or_create_by!(festival: mtq2016,
                                              restaurant: restaurant)
  end
  restaurant_tbl = restaurants.each_with_object({}) { |r, h|
    h[r.name] = r
  }
  r = restaurant_tbl["ホンソゴ"]
  [
    [1, "しまねOSS協議会"],
    [2, "まつえオープン・ソース・ソバ協議会"],
    [3, "Rails Girls Matsue 3rd"],
    [4, "Matsue.rb"],
    [5, "Pepper アトリエサテライト松江"],
    [6, "いわみくと！(大屋純一)"],
    [7, "出雲ITコミュニティ"],
    [8, "いわみくと！（佐々木大輔）"]
  ].each do |no, s_name|
    photo = (File.open(File.join(SAKE_PHOTO_DIR, "#{no}.png")) rescue nil)
    begin
      b = Brewery.find_or_create_by!(name: no)
      s = Sake.find_or_create_by!(brewery: b)
      s.name = s_name
      s.photo = photo
      s.save!
      SakeMenuItem.find_or_create_by!(festival: mtq2016, restaurant: r, sake: s)
    ensure
      photo.close if photo
    end
  end
end
