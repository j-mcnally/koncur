Rails.application.routes.draw do
  root to: 'repos#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resource :repos
  resource :login

  post "/webhook" => "webhooks#check"

  get "/invalid_user" => "pages#invalid", as: "invalid_user"


end
