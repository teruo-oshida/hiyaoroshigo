# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

RESTAURANT_ICON_DIR = File.expand_path("seeds/images/restaurant_icons", __dir__)

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
  mtq2016 = Festival.find_or_create_by!(name: "松江トランキーロ2016")
  mtq2016.start_at = Time.mktime(2016, 9, 18, 12, 0, 0)
  mtq2016.end_at = Time.mktime(2016, 9, 18, 18, 0, 0)
  mtq2016.save!
  restaurants = [
    ["そば遊山", "そば遊山", "35.469174", "133.054291", "yu-zan.png", 30],
    ["谷屋", "小料理 酒 谷屋", "35.466007", "133.058943", "taniya.png", 32],
    ["誘酒庵", "誘酒庵", "35.463729", "133.059200", "yushu-an.png", 38],
    ["老虎", "中国酒家 老虎", "35.465821", "133.059930", "lao-fuu.png", 30],
    ["東風", "手打ちそば 東風", "35.458775", "133.060870", "tofu-gochi.png", 20]
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
  CSV.parse(<<-EOF.gsub(/^\s*/, "")) do |r_name, b_name, s_name|
    東風,吉田酒造,"月山 純米吟醸生詰ひやおろし"
    東風,富士酒造,"出雲富士 秋雲純米ひやおろし"
    東風,木次酒造,"美波太平洋 純米原酒ひやおろし"
    そば遊山,池月酒造,"誉池月 純米ひやおろし改良雄町木槽しぼり生詰瓶火入れ"
    そば遊山,一宮酒造,"石見銀山 特別純米改良八反流ひやおろし"
    そば遊山,稲田本店,"稲田姫 いなたひめ良燗純米"
    老虎,旭日酒造,"十旭日 純米ひやおろし"
    老虎,千代むすび酒造,"千代むすび 純米強力60氷温ひやおろし"
    老虎,米田酒造,"豊の秋 純米生詰原酒ひやおろし"
    誘酒庵,福羅酒造,"山陰東郷 純米ひやおろし"
    誘酒庵,李白酒造,"李白 特別純米生詰ひやおろし"
    誘酒庵,岡田屋本店,"菊弥栄 純米酒秋あがり"
    谷屋,久米桜酒造,"純米八郷 70冷やおろし"
    谷屋,酒持田本店,"ヤマサン正宗 純米原酒七号ひやおろし"
    谷屋,華泉酒造,"華泉 津和野純米原酒秋ざかり"
  EOF
    r = restaurant_tbl[r_name]
    b = Brewery.find_or_create_by!(name: b_name)
    s = Sake.find_or_create_by!(name: s_name, brewery: b)
    SakeMenuItem.find_or_create_by!(festival: mtq2016, restaurant: r, sake: s)
  end
end
