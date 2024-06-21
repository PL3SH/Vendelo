module Authentication
extend ActiveSupport::Concern
  included do
    before_action :set_current_user
    before_action :protect_pages
    private
    def set_current_user#si usaramos find solamente al encontrar un usuario lanzaria un error(find y find_by buscan por id por defecto)
      Current.user =  User.find_by( id: session[:user_id]) if session[:user_id]
    end

    def protect_pages#cuando no encuentre un usuario se devolvera a la home por defecto de la pagina
      redirect_to new_session_path, alert: t('common.not_logged_in') unless Current.user
    end
    #metodo para autorizar la accion edit al usuario
  end
end
