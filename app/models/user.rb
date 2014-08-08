class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_skills
  has_many :skills, through: :user_skills

  has_many :user_projects
  has_many :projects, through: :user_projects
 
  has_many :notifications
  has_many :messages

  def administrating_projects
    self.projects.where(admin_id: self.id)
  end

  def projects_as_collaborator
    projs = projects.reject{|proj| proj.admin_id == self.id || proj.status == "completed"}
    projs.select do |project|
      project.user_projects.detect{|user_project| user_project.user_id == self.id}.approved
    end
  end

  def solicited_projects
    #Projects for which a user has signed up but not yet been approved
    projs = projects.reject{|proj| proj.admin_id == self.id}
    projs.select do |project|
      project.user_projects.detect{|user_project| user_project.user_id == self.id}.approved == false
    end
  end

  def is_admin_for?(project)
    self.id == project.admin_id
  end

  def is_not_admin_for?(project)
    !is_admin_for?(project)
  end

  def rated?(project)
    UserProject.where("user_id = ? AND project_id = ?", self.id, project.id).pluck(:rated).first
  end

  def skill_score(skill)
    UserSkill.find_by_user_id_and_skill_id(self.id, skill.id).pluck(:score).first
  end

  def self.matching_project_skills(project)
    if project.skills.length > 0
      project_skill_ids = project.skills.map(&:id)
      sql_for_skill_ids = project_skill_ids.map{"skill_id = ?"}.join(" OR ")
      self.joins(:skills).where(sql_for_skill_ids, *project_skill_ids).reject{|u|u.projects.include?(project)}.uniq.shuffle
    else
      return []
    end
  end

end