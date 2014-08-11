class RemoveRatedFromUserProjects < ActiveRecord::Migration
  def change
    remove_column :user_projects, :rated, :boolean
  end
end
