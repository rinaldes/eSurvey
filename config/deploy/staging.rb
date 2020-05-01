set :domain, "esurvey@117.54.12.61"
role :web, domain                     # Your HTTP server, Apache/etc
role :app, domain                     # This may be the same as your `Web` server
role :db,  domain, :primary => true  # This is where Rails migrations will run

set :deploy_to, "/home/esurvey/esurvey"
set :branch, 'master'
set :rails_env, 'production'

set :database, {:name => 'esurvey_production', :user => 'postgres', :password => 'postgres123'}

namespace :deploy do
  task :create_db do
    run "cd #{current_release} && bundle exec rake RAILS_ENV=production db:create"
  end
  
  task :reset_db do
    run "cd #{current_release} && bundle exec rake RAILS_ENV=production db:reset"
  end

  task :seed do
    run "cd #{current_release} && bundle exec rake RAILS_ENV=production  db:seed"
  end
end