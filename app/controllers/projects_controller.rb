class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit]

  def index
    @projects = Project.in_planning.order("created_at DESC")
  end

  def show

  end

  def edit

  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

end