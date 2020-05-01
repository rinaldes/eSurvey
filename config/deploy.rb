require 'capistrano/ext/multistage'
require "rvm/capistrano"
require 'bundler/capistrano'

set :application, "eSurvey"
set :stages, %w(staging production)
set :default_stage, 'staging'
set :use_sudo, false

set :rvm_ruby_string, "ruby-2.0.0-p594@esurvey"

set :ssh_options, {:forward_agent => true, :keys => %w(~/.ssh/id_rsa.pub)}
set :scm, :git
set :scm_passphrase, ""
set :repository, "ssh://git@bitbucket.org/mrramadhan13/esurvey.git"
set :scm_verbose, true

set :keep_releases, 5
set :deploy_via, :remote_cache
set :template_dir, "cached-copy/config/deploy/templates/"
set :shared_configs, %w(database.yml)

before "deploy:restart", "bundle:install"

after "deploy:setup", "deploy:create_assets_folder"
after "deploy:setup", "deploy:create_uploads_folder"

after "deploy", "deploy:link_db"
after "deploy", "deploy:cleanup"
after "deploy", "deploy:migrate"

after "deploy:migrate", "deploy:asset_precompile"
after "deploy:asset_precompile", "deploy:make_symlink_for_uploads"
# after "deploy:make_symlink_for_uploads", "stop"
# after "deploy", "start"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    # run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    stop
    start
  end

  desc "Run pending migrations on already deployed code"
  task :migrate do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:migrate --trace"
  end

  desc "Create symlinks database.yml "
  task :link_db do
    run "ln -f #{shared_path}/#{template_dir}database.yml #{latest_release}/config/database.yml"
  end

  task :config_setup, :except => { :no_release => true } do
    shared_configs.each do |config|
      location = fetch(:template_dir, "config/deploy") + "#{config}.erb"
      puts "#{location}: #{File.file?(location)}"
      File.file?(location) ? (template = File.read(location)) : next

      conf = ERB.new(template)

      run "mkdir -p #{shared_path}/config"
      put(conf.result(binding), "#{shared_path}/config/#{config}", {:via => :scp})
    end
  end
  
  task :asset_precompile, :roles => [:web, :app, :db] do
    run "cd #{release_path} && bundle exec rake assets:clean && ln -sf #{shared_path}/assets #{release_path}/public/assets && rm -rf #{release_path}/public/assets/* && RAILS_ENV=#{rails_env} bundle exec rake assets:precompile --trace"
  end

  task :make_symlink_for_uploads, :roles => [:web, :app, :db] do
    run "cd #{release_path} && ln -sf #{shared_path}/uploads #{release_path}/public/uploads && chmod -R 777 #{release_path}/public/uploads"
  end

  desc "create assets folder"
  task :create_assets_folder do
    run "cd #{shared_path} && mkdir assets"
  end

  desc "create uploads folder"
  task :create_uploads_folder do
    run "cd #{shared_path} && mkdir uploads"
  end
end

namespace :bundle do
  desc "run bundle install and ensure all gem requirements are met"
  task :install do
    run "cd #{release_path} && bundle install  --without=test --path=#{shared_path}/bundle"
  end
end

desc 'stop think rails server'
task :stop do
    run "kill -9 $(cat #{current_path}/tmp/pids/server.pid)"
end

desc 'start think rails server'
task :start do
  # run "cd #{current_path} && bundle exec thin -p 8080 -e production -l log/thin.log -d start"
  # run "cd #{current_path} && bundle exec unicorn -p 4000 -E production -D"
  run "cd #{current_path} && bundle exec rails s -e production -d"
end