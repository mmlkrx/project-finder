class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit]
  before_action :authenticate_user!, except: :index

  def index
    unless user_signed_in?
      redirect_to about_path
    end
    @projects = Project.matching_user_skills(current_user)
  end

  def create
    @project = Project.new(project_params)
    @project.user_projects.build(user_id: params[:project][:admin_id])
    if @project.save
      redirect_to current_user
    else
      flash.now[:alert] = "Project was not saved properly."
      render 'projects/index'
    end
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit

  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :admin_id, :skill_ids => [])
  end

  def set_project
    @project = Project.find(params[:id])
  end

end