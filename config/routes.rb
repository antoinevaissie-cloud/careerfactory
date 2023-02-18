Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # config/routes.rb
  resources :campaigns, only: [:create, :new, :edit, :index, :show]

  #As a candidate I can see all recruiters of the campaign
  get "campaigns/:campaign_id/recruiters", to: "recruiters#index", as: "recruiters"

  #As a recruiter I can see all students of the campaign
  get "campaigns/:campaign_id/students", to: "students#index", as: "students"
=begin
resources :campaigns do
      resources :users, only: [:index], as: :recruiters
  end
=end

  #As a batch student I can book a slot with a recruiter through Calendly API
  get "campaigns/:campaign_id/recruiters/:recruiter_id/new", to: "bookings#new", as: "bookings_new"
  post "campaigns/:campaign_id/recruiters/:recruiter_id/create", to: "recruiters#create", as: "bookings_create"



end
