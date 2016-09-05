require 'test_helper'

class SakeTemperatureTest < ActiveSupport::TestCase
  test "enabled returns only enabled records" do
    SakeTemperature.enabled.each do |st|
      assert_equal(true, st.enabled)
    end
  end
end
