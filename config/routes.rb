Rails.application.routes.draw do

  resources :users
  resources :members, only: %i[index show]
  resources :groups, only: %i[index show]
  resources :events, only: %i[index show]

  resources :users do
    resources :events, only: %i[index show create destroy update]
    resources :groups, only: %i[index show create destroy update] do
    resources :members, only: %i[index show create destroy update]
    end
  end

  root "groups#index"

  post '/auth/login', to: 'authentication#login'

end
