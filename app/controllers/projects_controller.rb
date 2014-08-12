class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit]
  before_action :authenticate_user!, except: :index

  def index
    if user_signed_in?
    @projects = Project.matching_user_skills(current_user).reject{|p|p.users.include?(current_user)}
    else
      redirect_to about_path
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      user_project = @project.user_projects.build(user_id: params[:project][:admin_id])
      user_project.save
      user_project.approved = true
      redirect_to current_user
    else
      flash.now[:alert] = "Project was not saved properly."
      redirect_to @project
    end
  end

  def show
    @messages = @project.messages
  end

  def new
    @project = Project.new
  end

  def edit

  end

  def invitations
    @user = current_user
    @projects = @user.invited_projects
    render 'invitations'
  end

  def my_projects
    @user = current_user
    @projects = @user.administrating_projects.in_progress_or_planning
    render 'my_projects'
  end

  def my_teams
    @user = current_user
    @projects = @user.projects_as_collaborator
    render 'my_teams'
  end

  def pending_applications
    @user = current_user
    @projects = @user.solicited_projects
    render 'pending_applications'
  end

  def finished_projects
    @user = current_user
    @projects = @user.projects.completed
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :admin_id, :skill_ids => [])
  end

  def set_project
    @project = Project.find(params[:id])
  end

end