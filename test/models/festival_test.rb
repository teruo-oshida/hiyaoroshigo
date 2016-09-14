require 'test_helper'

class FestivalTest < ActiveSupport::TestCase
  test "started?" do
    f = Festival.new(start_at: 1.second.since)
    assert_equal(false, f.started?)
    f = Festival.new(start_at: Time.current)
    assert_equal(true, f.started?)
    f = Festival.new(start_at: 1.second.ago)
    assert_equal(true, f.started?)
  end
end
