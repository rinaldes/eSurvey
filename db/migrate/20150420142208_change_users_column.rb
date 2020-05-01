class ChangeUsersColumn < ActiveRecord::Migration
  def up
  	change_column :users, :birth_date, :date
  	add_column :users, :image, :string
  end

  def down
  	change_column :users, :birth_date, :datetime
  	remove_column :users, :image, :string
  end
end
