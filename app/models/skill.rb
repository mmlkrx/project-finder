class Skill < ActiveRecord::Base
  belongs_to :category
  
  has_many :user_skills
  has_many :users, through: :user_skills

  has_many :project_skills
  has_many :projects, through: :project_skills

  def rated?(user, project)
    # UserSkill.where("user_id = ? AND skill_id = ?", user.id, self.id).pluck(:rated).first
    UserSkillProject.where("project_id = ? AND user_skill_id = ?", project.id, self.find_user_skill_id_by_user_id_and_skill_id(user, project)).pluck(:endorsed).first
  end

  def find_user_skill_id_by_user_id_and_skill_id(user, project)
    project.user_skills.where("user_id = ? AND skill_id = ?", user.id, self.id).pluck(:id).first
  end

  def endorsable?(current_user, user, project)
    #Test this thoroughly
    project != nil &&
    project.completed? &&
    !rated?(user, project) &&
    !current_user.is_not_admin_for?(project)
  end

end
