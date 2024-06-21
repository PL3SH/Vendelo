module Authorization
  extend ActiveSupport::Concern
  included do
    class NotAuthorizedError < StandardError; end #esta es una manera de hacer funciones de 1 linea
    rescue_from NotAuthorizedError do
      redirect_to products_path,alert: t('common.not_authorized')
    end
    private
    def authorize! record = nil
      #verficar que el id del usuario del producto sea igual al usuario que ha iniciado sesion actualmente

      #con controller_name obtenemos el nombre de algun controlador omite el _controller
      #con .singularize ruby pasara el plural a singular  (apps=> app)
      #concatenamos con Policy y usamos el metodo . classify que volvera una clase el string que mandemos(CamelCase)
      # el metodo .contatize convierte a una constante
      #asi obtenemos por ejemplo CategoryPolicy.new o ProductPolicy.new
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)


      raise NotAuthorizedError unless is_allowed #aplicamos una excepcion con raise y mandamos a que lidie con el error dentro de not authorizedEror
    end
  end
end
