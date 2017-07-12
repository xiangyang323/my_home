Rails.application.routes.draw do
  get 'users/new'

  root 'top#index'

  get 'login' => 'session#new'
  post 'login' => 'session#new'
  #get "change_password", :to => "users/passwords#edit"
  get "forget_password", :to => "session#forget_password"
  post "forget_password", :to => "session#forget_password"
  post 'signin' => 'session#create'
  get 'signin' => 'session#create'
  get 'logout' => 'session#destroy'

  get "session/get_verification", to: "session#get_verification"

  get "myhome", to: "home#index"
  post "myhome/upload_image", to: "home#upload_image"
  get "myhome/edit", to: "home#edit"
  post "myhome/edit", to: "home#edit"


  get "brand/new", to: "brand#new", as: :new_brand

end
