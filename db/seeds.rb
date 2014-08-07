brandon = User.create(name: "Brandon Hopkins", email: "bh@foo.com", password: "password123", password_confirmation: "password123")
tyler = User.create(name: "Tyler Durden", email: "td@foo.com", password: "password123", password_confirmation: "password123")
randall = User.create(name: "Randall Reed Jr.", email: "rr@foo.com", password: "password123", password_confirmation: "password123")
michael = User.create(name: "Michael", email: "m@foo.com", password: "password123", password_confirmation: "password123")
hercules = User.create(name: "Hercules", email: "h@foo.com", password: "password123", password_confirmation: "password123")

project_mayhem = Project.create(title: "Project Mayhem", description: "Havin some fun", status: "planning", admin_id: "#{tyler.id}")
project_node = Project.create(title: "Project Node", description: "Learning node", status: "planning", admin_id: "#{brandon.id}")
project_god = Project.create(title: "Project God", description: "Learning to be god", status: "planning", admin_id: "#{michael.id}")
project_fun = Project.create(title: "Project Fun", description: "Having a lot more fun", status: "completed", admin_id: "#{michael.id}")
project_progress = Project.create(title: "Project Making Tons of Progress", description: "Having a lot more fun", status: "in_progress", admin_id: "#{michael.id}")

brandon.projects << [project_mayhem, project_node]
randall.projects << project_node
tyler.projects << [project_mayhem, project_node]
michael.projects << [project_fun, project_node, project_mayhem]

project_mayhem.skills << [Skill.find_by_name("Marketing"), Skill.find_by_name("Copywriting")]
project_node.skills << [Skill.find_by_name("Node"), Skill.find_by_name("Python"), Skill.find_by_name("Ruby")]
project_god.skills << Skill.find_by_name("Organizing")

brandon.skills << [Skill.find_by_name("Ruby"), Skill.find_by_name("Marketing")]
tyler.skills << [Skill.find_by_name("Node"), Skill.find_by_name("Marketing"), Skill.find_by_name("Copywriting")]
randall.skills << Skill.find_by_name("Node")
michael.skills << Skill.find_by_name("Marketing")

brandon.save
tyler.save
randall.save
michael.save

UserProject.create(user_id: brandon.id, project_id: project_fun.id, approved: true)
UserProject.create(user_id: randall.id, project_id: project_fun.id, approved: true)
UserProject.create(user_id: hercules.id, project_id: project_progress.id, approved: false)
UserProject.create(user_id: brandon.id, project_id: project_progress.id, approved: true)


