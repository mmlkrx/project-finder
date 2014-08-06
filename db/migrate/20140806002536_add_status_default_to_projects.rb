class AddStatusDefaultToProjects < ActiveRecord::Migration
  def change
    change_column :projects, :status, :string, :default => "planning"
  end
end
