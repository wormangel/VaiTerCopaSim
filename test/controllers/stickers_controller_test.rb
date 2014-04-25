require 'test_helper'

class StickersControllerTest < ActionController::TestCase
  test "should get populate" do
    get :populate
    assert_response :success
  end

end
