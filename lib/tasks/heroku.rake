namespace :db do
  task :seed_skills => :environment do
    Skill.create(name: "ruby")
    Skill.create(name: "node")
    Skill.create(name: "marketing")
    Skill.create(name: "copywriting")
    Skill.create(name: "python")
    Skill.create(name: "database administration")
  end
end