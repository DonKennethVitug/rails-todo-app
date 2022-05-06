Rails.application.routes.draw do
  devise_for :users

  resources :tasks, except: [:index] do
    get 'delete'
  end

  root to: 'home#index'

  match '*path' => 'home#index', via: :all
end
