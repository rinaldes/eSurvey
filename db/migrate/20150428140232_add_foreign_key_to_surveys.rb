class AddForeignKeyToSurveys < ActiveRecord::Migration
  def up
  	add_column :surveys, :user_id, :integer
  end

  def down  	
  	remove_column :surveys, :user_id, :integer
  end
end
