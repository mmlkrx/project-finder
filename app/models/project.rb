class Project < ActiveRecord::Base

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :messages

  has_many :project_skills
  has_many :skills, through: :project_skills

  has_many :user_skill_projects
  has_many :user_skills, through: :user_skill_projects
  
  belongs_to :admin, class_name: 'User', foreign_key: :admin_id

  validates :title, presence: true
  validates :description, presence: true

  def prospective_applicants
    p = Project.find(self.id)
    UserProject.find(p).people_who_are_not_invited(p).people_who_are_not_approved(p)
                       .exclude_admin(p).collect{|up| User.find(up.user_id)}.uniq
  end

  def current_collaborators
    p = Project.find(self.id)
    UserProject.find(p).people_who_are_approved(p).exclude_admin(p)
               .collect{|up| User.find(up.user_id)}.uniq
  end

  def self.in_planning
    where(status: 'planning').order(created_at: :desc)
  end

  def self.in_progress
    where(status: 'in_progress').order(created_at: :desc)
  end

  def self.in_progress_or_planning
    where("status = ? OR status = ?", 'planning', 'in_progress').order(created_at: :desc)
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

  def has_matching_user_skills?
    skill_ids = skills.collect{|skill| skill.id}
    sql_for_skill_ids = skill_ids.map{"skill_id = ?"}.join(" OR ")
    !UserSkill.where(sql_for_skill_ids, *skill_ids).empty?
  end

  def skill_matching_users
    skill_ids = skills.collect{|skill| skill.id}
    sql_for_skill_ids = skill_ids.map{"skill_id = ?"}.join(" OR ")
    UserSkill.where(sql_for_skill_ids, *skill_ids)
    .collect{|us| User.find(us.user_id) unless self.users.include? User.find(us.user_id)}.uniq.compact
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
