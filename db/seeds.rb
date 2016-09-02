# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Festival.transaction do
  mtq2016 = Festival.find_or_create_by(name: "松江トランキーロ2016") { |m|
    m.start_at = Time.mktime(2016, 9, 18, 12, 0, 0)
    m.end_at = Time.mktime(2016, 9, 18, 18, 0, 0)
  }
  restaurants = ["そば遊山", "谷屋", "誘酒庵", "中国酒家 老虎", "東風"].map { |name|
    Restaurant.find_or_create_by(name: name)
  }
  restaurants.each do |restaurant|
    RestaurantParticipation.find_or_create_by(festival: mtq2016,
                                              restaurant: restaurant)
  end
end
