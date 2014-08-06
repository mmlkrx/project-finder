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

  def projects_as_admin
    projects.where(admin_id: self.id)
  end

  def projects_as_collaborator
    projects.where.not(admin_id: self.id)
  end

  # def collaborators
  #   #Find all users who are associated with projects that have the current user's id
  #   projects.joins(:users).where(id: id)
  # end


end