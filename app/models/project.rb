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

  # Project.in_planning.joins(:skills).uniq.where("skill_id = ? OR skill_id = ?", *[1,5])
  def self.matching_user_skills(user)
    user_skill_ids = user.skills.map(&:id)
    sql_for_skill_ids = user_skill_ids.map{"skill_id = ?"}.join(" OR ")
    self.in_planning.joins(:skills).uniq.where(sql_for_skill_ids, *user_skill_ids).order("created_at DESC")  
  end

end