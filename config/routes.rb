Rails.application.routes.draw do
  get 'users/new'

  root 'top#index'

  get 'login' => 'session#new'
  post 'signin' => 'session#create'
  get 'signin' => 'session#create'
  delete 'logout' => 'session#destroy'
end
