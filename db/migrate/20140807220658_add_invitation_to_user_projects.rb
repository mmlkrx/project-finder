class AddInvitationToUserProjects < ActiveRecord::Migration
  def change
    add_column :user_projects, :invitation, :boolean, default: false
  end
end