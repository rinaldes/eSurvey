source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Exception
gem 'exception_notification', '4.0.1'

# Authentication
gem 'devise'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

#Upload data
gem 'carrierwave'
# gem 'rmagick', '2.13.2'
gem 'mini_magick'

# Pagination
gem 'will_paginate', '~> 3.0.6'
gem 'kaminari'

# Pdf
gem 'prawn'

# Use unicorn as the app server
gem 'unicorn'

# Use thin as the app server
# gem 'thin'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
gem 'debugger', '~> 1.6.8', group: [:development, :test]
gem 'wicked'

gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
# rake db:sessions:create / rails generate active_record:session_migration
# rake db:migrate
# (App)::Application.config.session_store :active_record_store

gem "brakeman", "~> 2.6.1", require: false
group :development, :test do
#  gem "rspec-rails", "~> 3.0.0"
end

group :development do
  gem 'capistrano','2.13.5'
	gem 'capistrano-ext','1.2.1'
	gem 'rvm-capistrano','1.2.7',  require: false
end

group :development do
  gem "rubycritic", require: false
  gem "rubocop", require: false
  gem "rubocop-rspec"
end
