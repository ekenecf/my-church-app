Rails.application.routes.draw do

  resources :users
  resources :members, only: %i[index show]

  resources :users do
    resources :members, only: %i[index new show create destroy update]
    # resources :deals, only: %i[index new show create destroy]
  end

  post '/auth/login', to: 'authentication#login'

end
