class ChangeDefaultStatusUsers < ActiveRecord::Migration
  def up
  	change_column :users, :status, :string, default: "inactive"
  end

  def down
  	change_column :users, :status, :string, default: "active"
  end
end
