Rails.application.routes.draw do
  resources :estoques, only: [:index, :show, :create]
  resources :produtos
  resources :clientes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
