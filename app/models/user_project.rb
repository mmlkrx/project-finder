class UserProject < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  def self.find_by_user_id_and_project_id(user_id, project_id)
    where("user_id = ? AND project_id = ?", user_id, project_id).first
  end
  
end
