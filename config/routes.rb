Rails.application.routes.draw do
  resources :assignments
  resources :roles
  devise_for :users
  #devise_for :models
  get 'default/index'
  get 'recibo/recibo'
  post 'recibo/recibo'
  get 'recibo/dwl_recibo'
  post 'recibo/dwl_recibo'
  get 'recibo/indice'
  post 'recibo/indice'

  
 root :to => 'default#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
