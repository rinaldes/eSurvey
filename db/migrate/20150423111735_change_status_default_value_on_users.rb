class ChangeStatusDefaultValueOnUsers < ActiveRecord::Migration
  def up
  	change_column :users, :status, :string, default: "active"
  end

  def down
  	change_column :users, :status, :string, default: "inactive"
  end
end
