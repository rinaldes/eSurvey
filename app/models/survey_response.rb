class SurveyResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :response_questions
end
