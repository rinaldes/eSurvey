class CreateResponseQuestions < ActiveRecord::Migration
  def change
    create_table :response_questions do |t|
      t.integer :survey_question_id
      t.integer :survey_response_id
      t.string :answer

      t.timestamps
    end
  end
end
