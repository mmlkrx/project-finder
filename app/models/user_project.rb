class UserProject < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  def self.find_by_user_id_and_project_id(user_id, project_id)
    where("user_id = ? AND project_id = ?", user_id, project_id).first
  end

  def self.find_applicants(project)
    where("project_id = ?", project.id)
  end

  def self.exclude_admin(project)
    where.not("user_id = ?", project.admin_id)
  end

  def self.exclude_people_who_are_approved(project)
    where("approved = 'false'")
  end

  def self.exclude_people_who_are_invited(project)
    where("invitation = 'false'")
  end
  
end
