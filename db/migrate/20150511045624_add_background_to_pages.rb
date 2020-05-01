class AddBackgroundToPages < ActiveRecord::Migration
  def up
  	add_column :survey_pages, :background, :text
  end
  def down
  	remove_column :survey_pages, :background, :text
  end
end
