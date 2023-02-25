Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # config/routes.rb
  resources :campaigns, only: [:create, :new, :edit, :index, :show]
  get '/home', to: 'campaigns#home'
  get '/campaigns/choose_batch', to: 'campaigns#choose_batch', as: 'choose_batch'
  get '/campaigns/choose_recruiters', to: 'campaigns#choose_recruiters', as: 'choose_recruiters'
  get '/campaigns/choose_times', to: 'campaigns#choose_times', as: 'choose_times'

  #As a candidate I can see all recruiters of the campaign
  get "campaigns/:campaign_id/recruiters", to: "recruiters#index", as: "recruiters"

  #As a candidate or recruiter I can see all my bookings
  get "bookings/:user_id/bookings", to: "bookings#list_bookings", as: "list_bookings"

  #As a recruiter I can see all students of the campaign
  get "campaigns/:campaign_id/students", to: "students#index", as: "students"
=begin
resources :campaigns do
      resources :users, only: [:index], as: :recruiters
  end
=end
  post "cal_endpoint", to: 'bookings#handle_cal_webhook'
end
