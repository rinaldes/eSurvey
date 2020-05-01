class AlterSurveyQuestions < ActiveRecord::Migration
  def up
  	remove_column :survey_questions, :survey_id, :integer
  	add_column :survey_questions, :survey_page_id, :integer
  	add_column :survey_questions, :is_required, :integer, :default => false
  	add_column :survey_questions, :question_order, :integer
  end
  def down
  	add_column :survey_questions, :survey_id, :integer
  	remove_column :survey_questions, :survey_page_id, :integer
  	remove_column :survey_questions, :is_required, :integer, :default => false
  	remove_column :survey_questions, :question_order, :integer
  end
end
