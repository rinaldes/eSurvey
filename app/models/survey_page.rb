class SurveyPage < ActiveRecord::Base
	has_many :survey_questions

  mount_uploader :background, ImageUploader
end
