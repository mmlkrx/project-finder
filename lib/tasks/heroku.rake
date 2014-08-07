namespace :db do
  task :seed_categories_and_skills => :environment do

    File.open("skill_seed_data").each do |line|
      row = line.strip.split(",")
      category = Category.create(name: row[0])
      row[1..-1].each do |skill|
        category.skills.create(name: skill)
      end
    end

  end
end