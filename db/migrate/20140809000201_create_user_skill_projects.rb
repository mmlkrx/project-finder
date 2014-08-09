class CreateUserSkillProjects < ActiveRecord::Migration
  def change
    create_table :user_skill_projects do |t|
      t.integer :user_skill_id
      t.integer :project_id
      t.boolean :endorsed

      t.timestamps
    end
  end
end
