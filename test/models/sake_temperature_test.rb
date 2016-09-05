require 'test_helper'

class SakeTemperatureTest < ActiveSupport::TestCase
  test "enabled returns only enabled records" do
    assert_equal(3, SakeTemperature.enabled.count)
    SakeTemperature.enabled.each do |st|
      assert_equal(true, st.enabled)
    end
  end
end
