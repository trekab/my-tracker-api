Rails.application.routes.draw do
  # Api definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy] 
      resources :tokens, only: [:create]
      resources :products
      resources :categories, only: %i[index create update destroy]
    end
  end
end
