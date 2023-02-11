Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # config/routes.rb
  resources :campaigns, only: [:create, :new, :edit]

  #As a candidate I can see all recruiters of the campaign
  resources :campaigns do
      resources :users, as: :recruiters, only: [:index]
  end

  #As a batch student I can book a slot with a recruiter through Calendly API
  resources :campaigns do
    resources :recruiters, as: :recruiters do
        resources :bookings, only: [:create, :new]
    end
  end
end
