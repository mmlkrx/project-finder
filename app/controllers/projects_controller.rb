class ProjectsController < ApplicationController

  def index
    @projects = Project.in_planning.order("created_at DESC")
  end

end