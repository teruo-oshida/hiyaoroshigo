require 'test_helper'

class DrinkersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get drinkers_edit_url
    assert_response :success
  end

  test "should get show" do
    get drinkers_show_url
    assert_response :success
  end

end
