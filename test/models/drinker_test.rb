# require 'minitest/spec'
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

  test "checked_in?" do
    drinker = Drinker.create!(email: "foo@example.com", password: "password")
    assert_equal(false, drinker.checked_in?)
    Checkin.create!(drinker: drinker, restaurant_id: 4,
                    created_at: 30.minutes.ago)
    assert_equal(false, drinker.checked_in?)
    Checkin.create!(drinker: drinker, restaurant_id: 4,
                    created_at: 29.minutes.ago)
    assert_equal(true, drinker.checked_in?)
  end

  # describe "#sake_title" do
  #   subject { drinker.sake_title }
  #   let(:drinker) { Drinker.create!(email: "foo@example.com", password: "password") }
  #   it { assert_equal("酒勇者見習い", subject) }
  # end

  def drink(drinker, sake_id)
    drinker.drinkings.create!(festival_id: 1, restaurant_id: 4,
                              sake_id: sake_id, sake_temperature_id: 3)
  end

  test "#sake_title (without interval)" do
    drinker = Drinker.create!(email: "foo@example.com", password: "password")
    assert_equal("酒勇者見習い", drinker.sake_title)

    (1..4).each do |i|
      drink(drinker, i)
      assert_equal("酒勇者見習い", drinker.sake_title)
    end

    (5..7).each do |i|
      drink(drinker, i)
      assert_equal("日本酒初級戦士", drinker.sake_title)
    end

    (8..9).each do |i|
      drink(drinker, i)
      assert_equal("山陰酒武闘家", drinker.sake_title)
    end

    (10..15).each do |i|
      drink(drinker, i)
      assert_equal("呑み過ぎ遊び人", drinker.sake_title)
    end
  end

  test "#sake_title (with interval)" do
    drinker1 = Drinker.create!(email: "foo@example.com", password: "password")
    drinker2 = Drinker.create!(email: "bar@example.com", password: "password")

    Timecop.freeze

    (1..10).each do |i|
      Timecop.travel((i * 5.minutes).seconds.ago)
      drink(drinker1, i)
    end
    assert_equal("呑み過ぎ遊び人", drinker1.sake_title)

    (1..10).each do |i|
      Timecop.travel((i * 10.minutes).seconds.ago)
      drink(drinker2, i)
    end
    assert_equal("伝説の酒勇者", drinker2.sake_title)

    (11..15).each do |i|
      Timecop.travel((i * 5.minutes).seconds.ago)
      drink(drinker1, i)
    end
    assert_equal("伝説の酒勇者", drinker1.sake_title)

    Timecop.return
  end
end
