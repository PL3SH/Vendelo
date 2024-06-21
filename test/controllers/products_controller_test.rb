require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
  end

  test "should get index" do
    get products_path
    assert_response :success
  end

  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 12
    assert_select '.category', 10
  end

  test 'render a list of products filtered by categories' do
    get products_path(category_id: categories(:computers).id)
    assert_response :success
    assert_select '.product', 5
  end

  test 'render a list of products filtered by price' do
    get products_path(min_price: 160,max_price: 200 )
    assert_response :success
    assert_select '.product', 3
    assert_select 'h2', 'Nintendo Switch'

  end

  test 'render a list of products filtered by text' do
    get products_path(query_text: 'Macbook Air' )
    assert_response :success
    assert_select '.product', 1
    assert_select 'h2','Macbook Air'
  end

  test 'render a list of products by expensive prices' do
    get products_path(order_by: 'expensives' )
    assert_response :success
    assert_select '.product', 12
    assert_select '.product:first-child h2', 'Seat Panda clásico'
  end

  test 'render a list of products by cheaper prices' do
    get products_path(order_by: 'cheapest' )
    assert_response :success
    assert_select '.product', 12
    assert_select '.product:first-child h2', 'El hobbit'
  end

  test 'render a list of products by recent' do
    get products_path(order_by: 'newest' )
    assert_response :success
    assert_select '.product', 12
    assert_select '.product:first-child h2', 'Tabla de surf'
  end

  test 'render a detailed product page' do
    get product_path(products(:iphone))
    assert_response :success
    assert_select '.title', 'iPhone 13'
    assert_select '.description', 'Funciona correctamente.'
    assert_select '.price', '400$'
  end

  test 'render a new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'ps5',
        description: 'ps5 1 tera muy buen estado',
        price: 12000000,
        category_id: categories(:videogames).id
      }
    }
    assert_redirected_to products_path
    assert_equal 'tu producto ha sido creado', flash[:notice]
  end

  test 'does not allow to create new empty products' do
    post products_path, params: {
      product: {
        title: '',
        description: 'ps5 1 tera muy buen estado',
        price: 12000000
      }
    }
    assert_response :unprocessable_entity
  end

  test 'render an edit product form' do
    get edit_product_path(products(:iphone))
    assert_response :success
    assert_select 'form'
  end

  test 'allow to update a  product' do
    patch product_path(products(:iphone)), params: {
      product: {
        price: 23
      }
    }
    assert_redirected_to products_path
    assert_equal 'tu producto ha sido actualizado', flash[:notice]
  end

  test 'does not allow to update a  product' do
    patch product_path(products(:iphone)), params: {
      product: {
        price: nil
      }
    }
    assert_response :unprocessable_entity
  end

  test 'can delete products' do
    assert_difference('Product.count', -1) do
      delete product_url(products(:iphone))
    end
    assert_redirected_to products_path
    assert_equal flash[:notice], 'tu producto ha sido eliminado',status: :see_other
  end





end
