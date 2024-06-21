class CategoryPolicy < BasePolicy
  def method_missing(m,*args, &block)
    Current.user.admin?
  end
  #esto es un metodo encaso de que el metodo quen la logica trato de llamar no existe es coomo un default
end
