Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root 'users#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :conversations do
    member do
      post 'invite'
    end
    resources :messages
  end


end
