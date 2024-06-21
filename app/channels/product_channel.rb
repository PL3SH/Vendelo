class ProductChannel < ApplicationCable::Channel
  def subscribed
    #dividimos entre rooms para diferenciar a lo que los distintos clientes en el se4rvidor acceden en productos
    stream_from "product_#{params[:room]}"
  end
end
