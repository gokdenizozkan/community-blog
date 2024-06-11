Rails.application.routes.draw do
  root 'welcome#index'

  get 'up' => 'rails/health#show', as: :rails_health_check
  get '/users/:id', to: 'users/profiles#show', as: :user_profile
  get '/users/:id/edit_nickname', to: 'users/profiles#edit_nickname', as: :edit_user_nickname
  get '/search', to: 'articles#search', as: :search_article

  post '/votes/add', to: 'votes#add', as: :add_vote
  patch '/users/:id', to: 'users/profiles#update_nickname', as: :update_user_nickname

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' },
    skip: [:sessions, :registrations]

  devise_scope :user do
    get "/users", to: "devise/sessions#new", as: :new_user_session
    post "/users/sign_in", to: "devise/sessions#create", as: :user_session
    delete "/users/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  resources :tags
  resources :articles do
    resources :comments
    post '/comments/:id/approve', to:'comments#approve', as: :approve_comment
    post '/comments/:id/reject', to:'comments#reject', as: :reject_comment
  end

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :show]
    end
  end
end
