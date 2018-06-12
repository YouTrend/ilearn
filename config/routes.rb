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

  root "home#index"
end
