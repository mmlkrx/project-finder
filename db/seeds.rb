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

brandon.projects.create(title: "Project Mayhem", description: "Havin some fun", status: "planning")
randall.projects.create(title: "Project Node", description: "Learning node", status: "planning")

explosives = Skill.create(name: "explosives")
manipulation = Skill.create(name: "manipulation")
sales = Skill.create(name: "sales")

tyler.notifications.create(content: "You are woring on project mayhem")
