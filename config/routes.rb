Rails.application.routes.draw do

  get 'items_imports/new'

  get 'items_imports/create'

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
  resources :attendances do
    collection do
      post :create_by_zkteco
    end
  end

  resources :notifies

  namespace :oauth do
    get :index
    post :callback
    post :authorize
    post :send_message
    get '/authorize' => "oauth#get_authorize"
    get '/callback' => "oauth#index"
    get '/send_message' => "oauth#get_send_message"
  end
  namespace :helps do
    get :index
  end

  resources :items
  resources :items_imports, only: [:new, :create]

  root "home#index"
end
