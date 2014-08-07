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

  def as_admin
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

  def self.matching_project_skills(project)
    project_skill_ids = project.skills.map(&:id)
    sql_for_skill_ids = project_skill_ids.map{"skill_id = ?"}.join(" OR ")
    self.joins(:skills).uniq.where(sql_for_skill_ids, *user_skill_ids).order("created_at DESC")  
  end

end