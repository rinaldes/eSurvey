# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'bcrypt'

ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  if !["schema_migrations"].include?(table)
    puts "TRUNCATE #{table}"
    ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
  end
end

User.create!(
  :email => 'esurveypinus@gmail.com',
  :password => 'password',
  :encrypted_password => BCrypt::Password.create('password'),
  :confirmed_at => DateTime.now,
  :username => 'admin',
  :first_name => 'super',
  :last_name => 'admin',
  :birth_place => 'hometown',
  :birth_date => Date.today,
  :gender => 'male',
  :status => 'active',
  :role => 'admin'
)