class Skill < ActiveRecord::Base
  belongs_to :category
  
  has_many :user_skills
  has_many :users, through: :user_skills

  has_many :project_skills
  has_many :projects, through: :project_skills

  def rated?(user)
    UserSkill.where("user_id = ? AND skill_id = ?", user.id, self.id).pluck(:rated).first
  end

end
