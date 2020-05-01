class AddBackgroundColorToPages < ActiveRecord::Migration
  def up
  	add_column :survey_pages, :color, :string
  end

  def down
  	remove_column :survey_pages, :color, :integer
  end
end
