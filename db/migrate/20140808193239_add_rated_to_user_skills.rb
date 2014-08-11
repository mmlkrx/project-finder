class AddRatedToUserSkills < ActiveRecord::Migration
  def change
    add_column :user_skills, :rated, :boolean, default: false
  end
end
