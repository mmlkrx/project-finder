class UserSkill < ActiveRecord::Base

  belongs_to :user
  belongs_to :skill

  has_many :user_skill_projects
  has_many :projects, through: :user_skill_projects
  
  def self.find_by_user_id_and_skill_id(user_id, skill_id)
    where("user_id = ? AND skill_id = ?", user_id, skill_id)
  end

  def update_score
    self.score += 1
  end

end
