require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:paco)
  end

  test "should get show" do#al parecer este es el test que hace repetir lo de user tantas veces
    get user_url(@user.username)
    assert_response :success
  end
end
