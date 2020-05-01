class AddAnswerToQuestion < ActiveRecord::Migration
  def up
  	add_column :survey_questions, :answer, :text
  end
  def down
  	remove_column :survey_questions, :answer, :text
  end
end
