Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :boards do
    member do
      get :confirm_destroy
    end
    resources :comments, only: %i[show create edit update destroy ], shallow: true do
      member do
        get :confirm
      end
    end
  end
end
