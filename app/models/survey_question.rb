class SurveyQuestion < ActiveRecord::Base
	belongs_to :survey_page
	belongs_to :survey
  has_many :response_questions
 
 	serialize :varians, Hash
end
