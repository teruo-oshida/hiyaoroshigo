FactoryGirl.define do
  factory :drinking do
    sequence(:festival_id)         { |n| n }
    sequence(:drinker_id)          { |n| n }
    sequence(:restaurant_id)       { |n| n }
    sequence(:sake_id)             { |n| n }
    sequence(:sake_temperature_id) { |n| n }

    transient { interval 0.minutes }

    sequence(:created_at) { |n| (interval * n).seconds.ago }
  end
end
