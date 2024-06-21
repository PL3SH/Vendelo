require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @megadrive = products(:megadrive)#producto a darle like
    @switch = products(:switch)#producto dentro de los favoritos a darle dislike vease fixtures de favorites
  end

  test "should create favorite" do
    assert_difference('Favorite.count', 1) do
      post favorites_url(product_id: @megadrive.id)
    end
      assert_redirected_to product_path(@megadrive)
  end

  test "should return my favorites" do
    get favorites_url

    assert_response :success
  end
#los test que creeemos deben ser completames independientes entre si
  test "should delete favorite" do
    assert_difference('Favorite.count', -1) do
      delete favorite_url( @switch.id)
    end
    assert_redirected_to product_path(@switch)
  end
end
