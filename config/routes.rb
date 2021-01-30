Rails.application.routes.draw do
  get 'prescriptions/index'
  get 'prescriptions/:id', to: 'prescriptions#show', as: :prescription
  get 'prescriptions/create'
  get 'prescriptions/new'
  get 'prescriptions/create'
  get 'prescriptions/update'
  get 'prescriptions/delete'
  devise_for :users
  root to: 'dashboards#show'
  resources :patients, only: [ :index, :show, :new, :create] do
    resources :visits, only: [:new]
  end
  resources :visits, only: [ :index, :update, :destroy, :show, :new, :create]  do
    member do
      patch :mark_as_done
      patch :move
    end
    resources :minutes, only: [ :create ]
  end
  resources :journeys, only: [:update]  do
    member do
      get 'geometry'
    end
  end
end
