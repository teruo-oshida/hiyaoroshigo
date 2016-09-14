require 'test_helper'

class FestivalTest < ActiveSupport::TestCase
  test "started?" do
    f = Festival.new(start_at: 1.second.since)
    assert(false, f.started?)
    f = Festival.new(start_at: Time.current)
    assert(true, f.started?)
    f = Festival.new(start_at: 1.second.before)
    assert(true, f.started?)
  end
end
