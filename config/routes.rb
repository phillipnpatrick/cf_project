Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}, 
    controllers: { registrations: "user_registrations", sessions: 'users/sessions', passwords: 'users/passwords' }

  resources :products do
    resources :comments
  end

  resources :users
  
  resources :orders, only: [:index, :show, :create, :destroy]
  
  get 'simple_pages/about'
  
  get 'simple_pages/contact'
  
  get 'simple_pages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'simple_pages#index'
  
  root 'simple_pages#landing_page'
  
  post 'simple_pages/thank_you'
  
  get 'payments/create'
  post 'payments/create'

  mount ActionCable.server => '/cable'
  
end
