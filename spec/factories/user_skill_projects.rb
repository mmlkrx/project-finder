# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_skill_project do
    user_skill_id 1
    project_id 1
    endorsed false
  end
end
