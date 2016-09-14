require 'test_helper'

class SakeTest < ActiveSupport::TestCase
  test "winner" do
    sakes = Sake.all.map { |sake|
      sum_score = 10.times.map {
        Vote.create(drinking: Drinking.create(festival_id: 1, sake_id: sake.id),
                    score: rand(5) + 1).score
      }.sum
      [sake.id, sum_score]
    }
    winner, = sakes.max { |(_, x), (_, y)|  x <=> y }
    assert_equal(winner, Sake.winner.id)
  end
end
