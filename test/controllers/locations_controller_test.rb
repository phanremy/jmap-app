require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get locations_url
    assert_response :success
  end
end
