class AlterCollumnQuestion < ActiveRecord::Migration
  def up
  	remove_column :survey_questions, :question_type, :string
  	remove_column :survey_questions, :question_varians, :text
  	remove_column :survey_questions, :question_order, :integer
  	add_column :survey_questions, :type, :string
  	add_column :survey_questions, :varians, :text
  	add_column :survey_questions, :order, :integer
  end
  def down
  	remove_column :survey_questions, :type, :string
  	remove_column :survey_questions, :varians, :text
  	remove_column :survey_questions, :order, :integer
  	add_column :survey_questions, :question_type, :string
  	add_column :survey_questions, :question_varians, :text
  	add_column :survey_questions, :question_order, :integer
  end
end
