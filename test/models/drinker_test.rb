require 'test_helper'

class DrinkerTest < ActiveSupport::TestCase
  test "latest_checkin" do
    drinker = Drinker.create!(email: "foo@example.com", password: "password")
    assert_equal(nil, drinker.latest_checkin)
    c = Checkin.create!(drinker: drinker, restaurant_id: 4)
    assert_equal(c, drinker.latest_checkin)
    c2 = Checkin.create!(drinker: drinker, restaurant_id: 2)
    assert_equal(c2, drinker.latest_checkin)
  end

  test "checked_in_restaurant_id" do
    drinker = Drinker.create!(email: "foo@example.com", password: "password")
    assert_equal(nil, drinker.checked_in_restaurant_id)
    Checkin.create!(drinker: drinker, restaurant_id: 4)
    assert_equal(4, drinker.checked_in_restaurant_id)
    Checkin.create!(drinker: drinker, restaurant_id: 2)
    assert_equal(2, drinker.checked_in_restaurant_id)
  end
end
