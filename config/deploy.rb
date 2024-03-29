default_environment["PATH"] = "/usr/kerberos/sbin:/usr/kerberos/bin://sbin://bin:/opt/ruby-ee/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/root/bin"
default_run_options[:pty] = true

set :application, "yunus.gomet.be"
set :repository,  "git@github.com:iepsevere/holidays.git"

set :user, "students"

set :scm, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, application                          # Your HTTP server, Apache/etc
role :app, application                          # This may be the same as your `Web` server
role :db,  application, :primary => true # This is where Rails migrations will run

set :branch, "master"
set :deploy_to, "/var/www/vhosts/gomet.be/yunus"
set :deploy_via, :copy
set :scm_verbose, true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     migrate
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end