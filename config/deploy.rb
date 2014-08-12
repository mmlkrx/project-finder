require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :deploy_to, '/home/teamup/teamup'
set :repository, 'git@github.com:mmlkrx/project-finder.git'
set :branch, 'master'
set :user, 'teamup'
set :faye_config, "faye.ru"
set :app_path, "#{deploy_to}/#{current_path}"
set :domain, '107.170.81.60'
task :environment do

end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/pids"]

#   queue! %[/usr/bin/expect <<EOD
# spawn git clone git@github.com:flatiron-school/environmentalizer.git
# expect -re "(continue)"
# send "yes\n"
# expect eof
# EOD
#   ]
  # queue! %[rm -rf environmentalizer]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'bundle:install'

    to :launch do
      invoke :'faye:restart'
      #queue "rackup faye.ru -s thin -E production"
    end
  end
end

namespace :faye do
  desc "Restart Faye"
  task :restart => :environment  do
    queue "if kill -0 `cat #{deploy_to}/shared/pids/faye.pid`> /dev/null 2>&1; then kill -9 `cat #{deploy_to}/shared/pids/faye.pid`; else echo 'faye is not running'; fi"
    queue "cd #{app_path} && rackup faye.ru -s thin -E production -D --pid #{deploy_to}/shared/pids/faye.pid"
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

