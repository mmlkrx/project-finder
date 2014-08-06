class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit]

  def index
    @projects = Project.in_planning.order("created_at DESC")
  end

  def create
    @project = Project.new(project_params)
    @project.admin_id = params[:project][:admin_id]
    @project.users << current_user
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
    params.require(:project).permit(:title, :description, :skill_ids => [])
  end

  def set_project
    @project = Project.find(params[:id])
  end

end