Rails.application.routes.draw do
  
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :courses do     
    
  end

  namespace :courses do
  	resources :events do 
      collection do
        post :temp
      end
    end
  end

  resources :departments

  resources :students do
    resources :contacts
  	collection do
  		get :others
      get :search_auto_complete
      get :search
  	end
  	
    member do
      delete :destroy_courses
    end   

  end

  resources :events
  resources :attendances


  get 'oauth/index'

  post 'oauth/callback'

  post 'oauth/authorize'

  post 'oauth/send_message'

  get 'oauth/authorize' => "oauth#get_authorize"

  get 'oauth/callback' => "oauth#index"

  get 'oauth/send_message' => "oauth#get_send_message"

  root "home#index"
end
