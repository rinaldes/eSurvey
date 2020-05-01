class RenameType < ActiveRecord::Migration
  def up
  	rename_column :survey_questions, :type, :question_type
  end

  def down
  	rename_column :survey_questions, :question_type, :type
  end
end
