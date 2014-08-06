class UserProjectsController < ApplicationController

  def approve_collaboration
    binding.pry
    @user_project = UserProject.find_by(user_id: current_user.id, project_id: params[:project_id])
  end

end