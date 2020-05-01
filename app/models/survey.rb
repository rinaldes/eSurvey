class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :survey_pages
  has_many :survey_responses
  has_many :survey_questions

  validates :name, presence: true, uniqueness: true

  self.per_page = 5

   default_scope { order("period_start desc") } 
  
  def self.set_per_page(number)
    self.per_page = number
  end

  def self.get_responses_count(surveys)
    total_responses = 0 
    surveys.each do |survey|
      total_responses += survey.survey_responses.count
    end
    return total_responses
  end

  def self.get_all_responses_count(surveys)
    total_responses = 0 
    surveys.each do |survey|
      total_responses += User.all.count
    end
    return total_responses
  end

  def is_user_response(user)
    self.survey_responses.select{|response| response if response.user_id==user}
  end

end
