class Authentication::SessionsController < ApplicationController
  #ignoramos el callback before_action y el metodo  :protect_pages en esta ruta
  skip_before_action :protect_pages

  def new
  end

  def create
    #a la instancia de user la busca bajo la variable login y mediante or esta puede ser tanto un email como un username
    @user = User.find_by("email = :login OR username = :login", { login: params[:login] })
    pp @user

    if @user&.authenticate(params[:password])#el & sirve para decirle que ejecute el siguiente metodo solo si encuentra el valor a la variable
      session[:user_id] = @user.id
      redirect_to products_path, notice: t('.created')
    else
      redirect_to new_session_path, alert: t('.failed')
    end
  end
  def destroy
    session.delete(:user_id)
    redirect_to products_path, notice: t('.destroyed')
  end
end
