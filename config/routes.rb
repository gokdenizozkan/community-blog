Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'welcome#index'

  get 'up' => 'rails/health#show', as: :rails_health_check
  get '/users/:id', to: 'users/profiles#show', as: :user_profile
  get '/search', to: 'articles#search', as: :search_article
  post '/votes/add', to: 'votes#add', as: :add_vote

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
