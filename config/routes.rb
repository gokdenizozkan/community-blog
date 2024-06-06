Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "welcome#index"

  resources :articles do
    resources :comments
    post "/comments/:id/approve", to:"comments#approve", as: :approve_comment
    post "/comments/:id/reject", to:"comments#reject", as: :reject_comment
  end

  post "/votes/add", to: "votes#add", as: :add_vote
end
