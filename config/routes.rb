Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :courses

  namespace :courses do
  	resources :events
  end

  resources :departments

  resources :students do
  	collection do
  		get :others
  	end
  	
  	
  end
  resources :events

  root "home#index"
end
