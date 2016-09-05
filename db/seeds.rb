# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Sake.transaction do
  [
    [1, "ロック（加氷）", nil, false],
    [2, "冷酒", 1, true],
    [3, "常温", 2, true],
    [4, "ぬる燗", nil, true],
    [5, "お燗", 3, false],
    [6, "とびきり燗", nil, false]
  ].each do |id, name, position, enabled|
    st = SakeTemperature.find_or_create_by(id: id) { |s| s.name = name }
    st.name = name
    st.position = position
    st.enabled = enabled
    st.save!
  end
  mtq2016 = Festival.find_or_create_by(name: "松江トランキーロ2016")
  mtq2016.start_at = Time.mktime(2016, 9, 18, 12, 0, 0)
  mtq2016.end_at = Time.mktime(2016, 9, 18, 18, 0, 0)
  mtq2016.save!
  restaurants = ["そば遊山", "谷屋", "誘酒庵", "老虎", "東風"].map { |name|
    Restaurant.find_or_create_by(name: name)
  }
  restaurants.each do |restaurant|
    RestaurantParticipation.find_or_create_by(festival: mtq2016,
                                              restaurant: restaurant)
  end
end
