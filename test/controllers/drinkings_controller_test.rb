require 'test_helper'

class DrinkingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get drinkings_new_url
    assert_response :success
  end

  test "should get create" do
    get drinkings_create_url
    assert_response :success
  end

end
