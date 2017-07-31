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

  get "home", to: "home#index"
  post "home/upload_image", to: "home#upload_image"
  get "home/edit", to: "home#edit"
  post "home/edit", to: "home#edit"
  get "home/list", to: "home#list"

  get "home/post/new", to: "home/post#new"
  post "home/post/new", to: "home/post#new"
  post "home/post/upload_image", to: "home/post#upload_image"

  get "home/brand/new", to: "home/brand#new", as: :new_brand
  post "home/brand/new", to: "home/brand#new"

  post '/home/upload/create', to: 'home/upload#create'
  post '/home/upload/:id/update', to: 'home/upload#update', :constraints => {:id => /\d+/}


end
