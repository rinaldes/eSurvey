class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :description
      t.date :period_start
      t.date :period_end
      t.string :status
      t.string :back_page_url
      t.text :disclaimer
      t.timestamps
    end
  end
end
