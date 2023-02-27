Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/menu', to: "pages#menu", as: "menu"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # config/routes.rb
  resources :campaigns, only: [:create, :new, :edit, :index, :show]
  get '/home', to: 'campaigns#home'

  resources :choose_batches, only: %i[new create]
  resources :choose_recruiters, only: %i[new create]
  resources :choose_times, only: %i[new create]
  #As a candidate I can see all recruiters of the campaign
  get "campaigns/:campaign_id/recruiters", to: "recruiters#index", as: "recruiters"

  #As a candidate or recruiter I can see all my bookings
  get "bookings", to: "bookings#index", as: :list_bookings

  #As a recruiter I can see all students of the campaign
  get "campaigns/:campaign_id/students", to: "students#index", as: "students"
=begin
resources :campaigns do
      resources :users, only: [:index], as: :recruiters
  end
=end
  post "cal_endpoint", to: 'bookings#handle_cal_webhook'

  get 'recruiters/:id', to: 'recruiters#show', as: 'recruiter'

end
