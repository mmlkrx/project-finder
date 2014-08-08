class AddScoreToUserSkills < ActiveRecord::Migration
  def change
    add_column :user_skills, :score, :integer, default: 1
  end
end
