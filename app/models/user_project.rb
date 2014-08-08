class UserProject < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  def self.find_by_user_id_and_project_id(user_id, project_id)
    where("user_id = ? AND project_id = ?", user_id, project_id).first
  end

  def update_user_skill(new_rated_value)
    old_rated_value = self.rated
    if old_rated_value != new_rated_value
      
    end
  end
  
end
