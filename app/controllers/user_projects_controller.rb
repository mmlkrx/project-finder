class UserProjectsController < ApplicationController

  def approve_collaboration
    @user_project = UserProject.find_by(user_id: params[:user_id], project_id: params[:project_id])
    @user_project.approved = true
    @user_project.save
    @user = User.find(params[:user_id])
    @project = Project.find(params[:project_id])
    @user.notifications.build(content: "You're approved to work on #{@project.title}").save
    redirect_to @project
  end

  def deny_collaboration

  end

end