class RenameIsRequired < ActiveRecord::Migration
  def up
  	rename_column :survey_questions, :is_required, :required
  end

  def down
  	rename_column :survey_questions, :required, :is_required
  end
end
