class UserSkillProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user_skill
end
