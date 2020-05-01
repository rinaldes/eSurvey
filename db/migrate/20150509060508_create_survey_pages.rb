class CreateSurveyPages < ActiveRecord::Migration
  def change
    create_table :survey_pages do |t|
      t.integer :survey_id
      t.string :title
      t.text :description
      t.string :paginate_question_by
      t.integer :paginate_question_id

      t.timestamps
    end
  end
end
