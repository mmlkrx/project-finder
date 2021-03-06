Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root 'projects#index'

  resources :messages, only: :create
  resources :projects, only: [:show, :edit, :create, :new]
  get '/about' => 'application#about', as: "about"

  get '/invitations' => 'projects#invitations', as: 'invitations'
  get '/my_projects' => 'projects#my_projects', as: 'my_projects'
  get '/my_teams' => 'projects#my_teams', as: 'my_teams'
  get '/pending_applications' => 'projects#pending_applications', as: 'pending_applications'
  get '/finished_projects' => 'projects#finished_projects', as: 'finished_projects'

  post 'approve_collaboration' => 'user_projects#approve_collaboration', as: "approve_collaboration"  
  post 'deny_collaboration' => 'user_projects#deny_collaboration', as: "deny_collaboration"  
  post 'apply_for_project' => 'user_projects#apply_for_project', as: 'apply_for_project'
  post 'invite' => 'user_projects#invite', as: 'invite'
  post 'accept_invitation' => 'user_projects#accept_invitation', as: 'accept_invitation'
  post 'leave_project' => 'user_projects#leave_project', as: 'leave_project'
  post 'remove_user_from_project' => 'user_projects#remove_user_from_project', as: 'remove_user_from_project'
  post 'close_project' => 'user_projects#close_project', as: 'close_project'
  post 'in_progress' => 'user_projects#in_progress', as: 'in_progress'
  post 'update' => 'user_projects#update', as: 'update'

end
