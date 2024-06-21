class FavoritesController < ApplicationController

  def index

  end
  def create#creamos 2 variables que guardaran el producto y el usuario actual
    product.favorite!
    respond_to do |format|
      format.html do
        redirect_to product_path(product)
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: product })
      end
    end

  end

  def destroy
    product.unfavorite!
    respond_to do |format|
      format.html do

    redirect_to product_path(product),status: :see_other
      end
      format.turbo_stream do
        #en replace bscara un id de html a reemplazar
        render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product})
      end
    end


   
  end
private
  def product
    #memorization cacheal el resultado del metodo
    @product ||= Product.find(params[:product_id])
  end

end
#atencio  NN ASLKASJK
#EL MINUTO DEL VIDEO DONDE NOS QUEDAMOS FUE EN 5:44 DEL CAP 43
