class AddSurveyIdToQuestion < ActiveRecord::Migration
  def up
  	add_column :survey_questions, :survey_id, :integer
  end
  def down
  	remove_column :survey_questions, :survey_id, :integer
  end
end
