class Project < ActiveRecord::Base

  has_many :user_projects
  has_many :users, through: :user_projects

  has_many :project_skills
  has_many :skills, through: :project_skills
  belongs_to :admin, class_name: 'User', foreign_key: :admin_id

  def prospective_collaborators
    #users.joins("user_projects").where("users.id != ?", self.admin_id).where("user_projects.approved = 'false'")
    prspc = users.reject{|user| user.id == self.admin_id}
    prspc.reject! do |user|
      proj = user.user_projects.detect{|proj| proj.project_id == self.id}
      proj.approved
    end
    return prspc

  end

  def current_collaborators
    prspc = users.reject{|user| user.id == self.admin_id}
    prspc.reject! do |user|
      proj = user.user_projects.detect{|proj| proj.project_id == self.id}
      proj.approved == false
    end
    return prspc
  end

  def self.in_planning
    where(status: 'planning')
  end

  def self.in_progress
    where(status: 'in_progress')
  end

  def self.completed
    where(status: 'completed')
  end

end
