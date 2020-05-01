class RemoveUnusedUsersField < ActiveRecord::Migration
  def up
  	remove_column :users, :password_hash
  	remove_column :users, :password_salt
  	change_column :users, :role, :string, default: "responder"
  	change_column :users, :status, :string, default: "inactive"
  end

  def down
  	add_column :users, :password_hash, :string
  	add_column :users, :password_salt, :string
  	change_column :users, :role, :string, default: ""
  	change_column :users, :status, :string, default: ""
  end
end
