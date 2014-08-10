class Project < ActiveRecord::Base

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :messages

  has_many :project_skills
  has_many :skills, through: :project_skills

  has_many :user_skill_projects
  has_many :user_skills, through: :user_skill_projects
  
  belongs_to :admin, class_name: 'User', foreign_key: :admin_id

  def prospective_applicants
    p = Project.find(self.id)
    UserProject.find_applicants(p).exclude_admin(p).exclude_people_who_are_invited(p)
               .exclude_people_who_are_approved(p).collect{|up| User.find(up.user_id)}
  end

  def current_collaborators
    prspc = users.reject{|user| user.id == self.admin_id} # excluding Admin from team
    prspc.reject! do |user|
      proj = user.user_projects.detect{|proj| proj.project_id == self.id}
      proj.approved == false
    end
    return prspc.uniq
  end

  def self.in_planning
    where(status: 'planning')
  end

  def self.in_progress
    where(status: 'in_progress')
  end

  def self.in_progress_or_planning
    where("status = ? OR status = ?", 'planning', 'in_progress')
  end

  def self.completed
    where(status: 'completed')
  end

  def completed?
    self.status == 'completed'
  end

  def not_completed?
    !completed?
  end

  # Uniq has to be called because we want a project as soon as one user skill matches one
  # of the project tagged skills. Otherwise it's going to return the same project as often as
  # any user skills match with associated project skills
  
  def self.matching_user_skills(user)
    if user.skills.length > 0
      user_skill_ids = user.skills.map(&:id)
      sql_for_skill_ids = user_skill_ids.map{"skill_id = ?"}.join(" OR ")
      self.in_planning.joins(:skills).where(sql_for_skill_ids, *user_skill_ids).order("created_at DESC").uniq
    else
      return []
    end
  end

end
