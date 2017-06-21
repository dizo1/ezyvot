Rails.application.routes.draw do
  
  devise_for :users, controllers: { :omniauth_callbacks => "user/omniauth_callbacks"}
  devise_scope :user do
  get 'sign_in', to: 'devise/sessions#new'
  #get "sign_in", to: "user/user_sessions#create"
  get 'users/sign_out' => "devise/sessions#destroy"
end

#devise_scope :user do
#  get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
#  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
#end

#get 'contestants/:id/like'

  resources :contestants do 
    member do
      put 'like' => 'contestants#upvote'
    end
  end
  
  resources :pageants do
    resources :contestants, except: [:show, :index]
       
  end
  root 'pageants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
