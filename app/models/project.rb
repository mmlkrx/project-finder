class Project < ActiveRecord::Base

  has_many :user_projects
  has_many :users, through: :user_projects

  has_many :project_skills
  has_many :skills, through: :project_skills

  def prospective_collaborators
   
  end

  def current_collaborators

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
