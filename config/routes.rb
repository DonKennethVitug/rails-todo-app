Rails.application.routes.draw do
  devise_for :users

  resources :tasks, except: [:index] do
    get 'delete'
  end

  root to: 'home#index'

  # Letter Opener Web UI
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  match '*path' => 'home#index', via: :all
end
