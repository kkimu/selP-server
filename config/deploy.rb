# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'selp-server'
set :repo_url, 'git@github.com:kkimu/selP-server.git'
set :web_api_repo, 'git@github.com:dulltz/selP-web-api'
set :cv_repo, 'git@github.com:dulltz/selP-cv'
set :scm, :git
set :deploy_to, "/home/deploy/selp"
set :branch, "deploy"
set :pty, true

desc "deploy selp"
task :deploy do
	on roles(:web) do
		deploy_to = fetch :deploy_to
		branch = fetch :branch

		execute "cd #{deploy_to}/current; git clone #{fetch :web_api_repo} web-api; git clone #{fetch :cv_repo} cv; sudo chown deploy:deploy -R *; sudo bash -l setup.sh"
	end
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
