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
brandon.save
randall.save

explosives = Skill.create(name: "explosives")
manipulation = Skill.create(name: "manipulation")
sales = Skill.create(name: "sales")

brandon.skills << [explosives, sales]
tyler.skills << [manipulation, sales]
randall.skills << manipulation
brandon.save
tyler.save
randall.save

tyler.notifications.create(content: "You are woring on project mayhem")
