Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root 'projects#index'

  resources :projects, only: [:show, :edit]
  post 'approve_collaboration' => 'user_projects#approve_collaboration', as: "approve_collaboration"  

end
