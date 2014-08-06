Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root 'projects#index'

  resources :projects, only: [:show, :edit, :create, :new]
  post 'approve_collaboration' => 'user_projects#approve_collaboration', as: "approve_collaboration"  
  post 'deny_collaboration' => 'user_projects#deny_collaboration', as: "deny_collaboration"  
  get '/about' => 'application#about', as: "about"

end
