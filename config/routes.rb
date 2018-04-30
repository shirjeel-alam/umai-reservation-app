Rails.application.routes.draw do
  resources :restaurants, only: [] do
    resources :reservations, only: [:index, :create, :update]
  end

  get 'welcome/index'
  root 'welcome#index'
end
