Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboards#show'
  resources :patients, only: [:index, :show, :new, :create] do
    resources :prescriptions, only: [:new, :create]
  end
  resources :prescriptions do
    resources :visits, only: [:new, :create]
  end
  resources :visits, only: [:index, :update, :destroy, :show, :new, :create]  do
    member do
      patch :mark_as_done
      patch :move
    end
    resources :minutes, only: [:create]
  end
  resources :journeys, only: [:update]  do
    member do
      get 'geometry'
    end
  end
end
