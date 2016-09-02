# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Festival.transaction do
  mtq2016 = Festival.create!(name: "松江トランキーロ2016",
                             start_at: Time.mktime(2016, 9, 18, 12, 0, 0),
                             end_at: Time.mktime(2016, 9, 18, 18, 0, 0))
  for name in ["そば遊山", "谷屋", "誘酒庵", "中国酒家 老虎", "東風"]
    restaurant = Restaurant.create!(name: name)
    mtq2016.restaurants << restaurant
  end
  mtq2016.save!
end
