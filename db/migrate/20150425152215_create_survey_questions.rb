class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
    	t.integer :survey_id
    	t.string :title
    	t.string :help
    	t.string :question_type
    	t.text :question_varians
      t.timestamps
    end
  end
end
