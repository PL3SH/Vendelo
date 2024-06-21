Rails.application.routes.draw do

    namespace :authentication,path: '',as: '' do
    resources :users,only:[:new,:create] ,path: '/register',path_names:{new:'/'}           #esto creara solo estas accxiones para users
    resources :sessions, only: [:new, :create,:destroy],path: '/login',path_names:{new:'/'}
      end
      resources :favorites,only: [:create,:destroy,:index],param: :product_id
      resources :users, only: :show, path: '/user', param: :username
  resources :categories,except: :show
#resources :products_path resume todas las routes que realizamos anteriormente
  resources :products, path: '/'#con esto hacemos que la pagina siempre inicien en home osea localhost/3000


end
