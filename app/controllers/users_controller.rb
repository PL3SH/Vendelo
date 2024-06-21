class UsersController < ApplicationController
  skip_before_action :protect_pages, only: :show
def show
  #con el simbolo ! podemos hacer una exceopcion asi que si lo que esta antes no cumple la condicion se para el proceso
  @user = User.find_by!(username: params[:username] )
  #reusamos el codigo pero ahora buscara los productos segun el usuario
 
end




end
