class AddAdminIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :admin_id, :integer
  end
end