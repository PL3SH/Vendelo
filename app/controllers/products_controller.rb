class ProductsController < ApplicationController
  skip_before_action :protect_pages,only: [:index,:show]
  def index
      #ordena las categorias de manera ascendente
    @categories = Category.order(name: :asc).load_async
    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)
  end

  def show
    product
  end
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice:  t('.created')#generara un texto en la parte superior de la pagina con el mensaje
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    #obtenemos el producto y llamamos al policie
    authorize! product
  end

  def update
    authorize! product #policie para proteger este producto
    #si clickeamos el boton de actualizar nos redireccionara al index y mostrara un mensaje
    if product.update(product_params)
     product.broadcast
      redirect_to products_path,notice: t('.updated')
    else#si todo sale mal generara un error de estado :unprocessable_entity
      render :edit,status: :unprocessable_entity
    end

  end
  def destroy
    authorize! product
    product.destroy
    redirect_to products_path, notice: t('.destroyed')
  end
  private
  def product
    #buscara por medio de un parametro dinamico (id) el producto que necesite
    #usamos memorization ||=
    @product ||= Product.find(params[:id])#ahora hemos convertido esto en una funcion por lo que podremos llamarlo y aplicar los cambios directamente
  end

  def product_params_index
    #estos son los parametros por los que vamos a filtar a lo largo de la pagina
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by,:page,:favorites,:user_id)
  end
  def product_params
    #restringimos la creacio de los productos segun ciertos parametros obligatorios
    params.require(:product).permit(:title,:description,:price,:photo,:category_id)
  end

 

end
