require 'test_helper'

class Apiv2::PsusControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
