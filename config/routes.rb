Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboards#show'
  resources :patients, only: [ :index, :show, :new, :create]

  resources :visits, only: [ :index, :update, :destroy, :show ]  do
    member do
      patch :mark_as_done
    end
    resources :minutes, only: [ :create ]
  end

  resources :visits do
    member do
      patch :move
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
