class AddOrderToPage < ActiveRecord::Migration
  def up
  	add_column :survey_pages, :order, :integer
  end
  def down
  	remove_column :survey_pages, :order, :integer
  end
end
