Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :cards

  namespace :admin do
    resources :cards do
      resource :effect, only: :show
    end
  end

  root "scores#index"

end
