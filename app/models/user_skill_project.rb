class UserSkillProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user_skill

  def self.find_by_user_skill_id_and_project_id(us_id, project_id)
    where("user_skill_id = ? AND project_id = ?", us_id, project_id).first
  end
end
