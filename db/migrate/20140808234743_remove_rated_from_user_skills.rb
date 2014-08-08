class RemoveRatedFromUserSkills < ActiveRecord::Migration
  def change
    remove_column :user_skills, :rated, :boolean
  end
end
