FactoryGirl.define do
  factory :drinker do
    sequence(:email) { |n| "example+#{n}@example.com" }
    password 'password'

    transient do
      drinking_count    0
      drinking_interval 0.minutes
    end

    after(:build) do |drinker, evaluator|
      next if (count = evaluator.drinking_count).zero?
      create_list(:drinking, count,
                  drinker:  drinker,
                  interval: evaluator.drinking_interval)
    end
  end
end
