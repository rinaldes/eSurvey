class DashboardController < ApplicationController
  def index
  	@survey = Survey.where("period_end BETWEEN '#{Date.today.beginning_of_month.strftime("%F %T")}' AND '#{Date.today.end_of_month.strftime("%F %T")}' AND status='open'").limit(6)
    @users_count = User.all.count
  	@all_responses = Survey.get_responses_count(@survey)

  	one_year_surveys = Survey.where("period_end BETWEEN '#{Date.today.beginning_of_year.strftime("%F %T")}' AND '#{Date.today.end_of_year.strftime("%F %T")}'")
    @one_year_responses = Survey.get_responses_count(one_year_surveys)
  	@all_one_year_responses = Survey.get_all_responses_count(one_year_surveys)

  	@surveys = Survey.all
  end
end
