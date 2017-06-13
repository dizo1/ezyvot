Rails.application.routes.draw do
  
  devise_for :users, controllers: { sessions: "devise/sessions" }
  devise_scope :user do
  get 'sign_in', to: 'devise/sessions#new'
  #get "sign_in", to: "user/user_sessions#create"
  get 'users/sign_out' => "devise/sessions#destroy"
end

get "contestants/like" => "contestants#like"

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
