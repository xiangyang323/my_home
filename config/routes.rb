Rails.application.routes.draw do
  get 'user/new'

  root 'top#index'

  get 'login' => 'session#new'
  post 'login' => 'session#new'
  #get "change_password", :to => "user/passwords#edit"
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

  get "home/post/list", to: "home/post#list"
  post "home/post/list", to: "home/post#list"
  get "home/post/new", to: "home/post#new"
  post "home/post/new", to: "home/post#new"
  get "home/post/new/:id", to: "home/post#new", as: :home_post_edit
  post "home/post/new/:id", to: "home/post#new"
  post "home/post/change_flag/:id", to: "home/post#change_flag"
  delete "home/post/delete/:id", to: "home/post#delete", as: :home_post_delete
  post "home/post/upload_image", to: "home/post#upload_image"

  get "home/activity/list", to: "home/activity#list"
  post "home/activity/list", to: "home/activity#list"
  get "home/activity/new", to: "home/activity#new"
  post "home/activity/new", to: "home/activity#new"
  get "home/activity/new/:id", to: "home/activity#new", as: :home_activity_edit
  post "home/activity/new/:id", to: "home/activity#new"
  post "home/activity/upload_image", to: "home/activity#upload_image"

  get "home/brand/new", to: "home/brand#new", as: :new_brand
  post "home/brand/new", to: "home/brand#new"
  get "home/brand/list", to: "home/brand#list"
  get "home/brand/bind", to: "home/brand#bind"

  post '/home/upload/create', to: 'home/upload#create'
  post '/home/upload/:id/update', to: 'home/upload#update', :constraints => {:id => /\d+/}

  get "post/:id", to: "post#show", as: :post

  get "/favorite/:id", to: "home#favorite", as: :favorite

end
