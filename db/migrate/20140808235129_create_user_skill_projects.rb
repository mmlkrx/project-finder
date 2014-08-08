class CreateUserSkillProjects < ActiveRecord::Migration
  def change
    create_table :user_skill_projects do |t|
      t.boolean :endorsed, default: false

      t.timestamps
    end
  end
end
