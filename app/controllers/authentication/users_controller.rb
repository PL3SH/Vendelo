
class Authentication::UsersController < ApplicationController
   #ignoramos el callback before_action y el metodo  :protect_pages en esta ruta
   skip_before_action :protect_pages
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    #@user.country = FetchCountryService.new(request.remote_ip).perform

    if @user.save
      #llammar al backgroundjob
      FetchCountryJob.perform_later(@user.id,request.remote_ip)
      session[:user_id] = @user.id#esto se representa como que la llave user_id posee de valor @user.id
      redirect_to products_path,notice: t('.created')
      UserMailer.with(user: @user).welcome.deliver_later
    else
      render :new,status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:email,:username,:password) #primero debe tener el objeto de user una instancia
    end
end
