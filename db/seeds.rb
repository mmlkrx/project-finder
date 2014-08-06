# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

brandon = User.create(name: "Brandon Hopkins", email: "bh@foo.com", password: "password1234", password_confirmation: "password1234")
tyler = User.create(name: "Tyler Durden", email: "td@foo.com", password: "password1234", password_confirmation: "password1234")
randall = User.create(name: "Randall Reed Jr.", email: "rr@foo.com", password: "password1234", password_confirmation: "password1234")

project_mayhem = Project.new(title: "Project Mayhem", description: "Havin some fun", status: "planning")
project_node = Project.new(title: "Project Node", description: "Learning node", status: "planning")
brandon.projects << project_mayhem
randall.projects << project_node
tyler.projects << [project_mayhem, project_node]
brandon.save
randall.save
tyler.save

internet = Category.create(name: "Internet")
business = Category.create(name: "Business")

ruby = Skill.create(name: "ruby")
node = Skill.create(name: "node")
marketing = Skill.create(name: "marketing")
copywriting = Skill.create(name: "copywriting")

internet.skills << [ruby, node]
business.skills << [marketing, copywriting]

internet.save
business.save

brandon.skills << [ruby, marketing]
tyler.skills << [node, marketing, copywriting]
randall.skills << node
brandon.save
tyler.save
randall.save

tyler.notifications.create(content: "You are woring on project mayhem")
