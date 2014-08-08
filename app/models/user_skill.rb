class UserSkill < ActiveRecord::Base

  belongs_to :user
  belongs_to :skill
  
  def self.find_by_user_id_and_skill_id(user_id, skill_id)
    where("user_id = ? AND skill_id = ?", user_id, skill_id).first
  end

  def update_score
    self.score += 1
  end

end
