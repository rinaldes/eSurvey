class ResponsesController < ApplicationController
  before_action :authenticate_admin, only: [:index, :filter]
  
  def index
  	if params[:survey].present?
  		@survey = Survey.new(survey_params)
  		
  		params_survey = params[:survey]
	  	
	  	params_name = params_survey[:name].upcase.gsub("'", "\\\'").gsub("\"", "\\\"")

	  	params_period_start = change_format(params_survey[:period_start]) if params_survey[:period_start].present?
	  	params_period_end = change_format(params_survey[:period_end]) if params_survey[:period_end].present?
	  	params_status = params_survey[:status].upcase unless params_survey[:status] == "all"

	  	puts params_period_start

	    where_clauses = []
	    where_clauses << "UPPER(name) LIKE '%#{params_name}%'" if params_name.present?
	    where_clauses << "period_start >= '#{params_period_start}'" if params_period_start.present?
	    where_clauses << "period_end <= '#{params_period_end}'" if params_period_end.present?
	    where_clauses << "UPPER(status) = '#{params_status}'" if params_status.present?

	    base_survey = Survey.where(where_clauses.join(" AND "))
  	else
  		@survey = Survey.new
    	base_survey = Survey.all
  	end

    @surveys_count = base_survey.count
    @surveys = base_survey.paginate(:page => params[:page])

    @send_survey = Survey.find(params[:id]) if params[:id].present?

    respond_to do |format|
      format.html
      format.js
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + @send_survey.name + " on " + DateTime.now.strftime("%d %B %Y %T").to_s + '.xls"'
      end
    end
  end

  def filter
    if params[:survey].present?
      @survey = Survey.new(survey_params)
      
      params_survey = params[:survey]
      
      params_name = params_survey[:name].upcase.gsub("'", "\\\'").gsub("\"", "\\\"")

      params_period_start = change_format(params_survey[:period_start]) if params_survey[:period_start].present?
      params_period_end = change_format(params_survey[:period_end]) if params_survey[:period_end].present?
      params_status = params_survey[:status].upcase unless params_survey[:status] == "all"

      puts params_period_start

      where_clauses = []
      where_clauses << "UPPER(name) LIKE '%#{params_name}%'" if params_name.present?
      where_clauses << "period_start >= '#{params_period_start}'" if params_period_start.present?
      where_clauses << "period_end <= '#{params_period_end}'" if params_period_end.present?
      where_clauses << "UPPER(status) = '#{params_status}'" if params_status.present?

      base_survey = Survey.where(where_clauses.join(" AND "))
    else
      @survey = Survey.new
      base_survey = Survey.all
    end

    @surveys_count = base_survey.count
    @surveys = base_survey.paginate(:page => params[:page])

    @send_survey = Survey.find(params[:id]) if params[:id].present?

    respond_to do |format|
      format.html
      format.js
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + @send_survey.name + " on " + DateTime.now.strftime("%d %B %Y %T").to_s + '.xls"'
      end
    end
  end

  def create
    set_value(params, params[:id])
    if session[current_user.id.to_s]['response'][params[:id]].present?
      survey_response = SurveyResponse.new
      survey_response.user_id = current_user.id
      survey_response.survey_id =  params[:id]
      survey_response.save
      
      session[current_user.id.to_s]['response'].each do |id, response|
        response_question = ResponseQuestion.new
        response_question.survey_question_id = id
        response_question.survey_response_id = survey_response.id
        
        question_type = response.first.first
        # p question_type
        unless response.first.last.is_a?(String)
          response_array = []
          # p response.first.last
          response.first.last.each do |key, value|
            if key == "other_text"
              response_array << value if value != "" && response.first.last["other"].to_i==1
            else
              if question_type == "textbox_text"
                response_array << value if value != ""
              elsif question_type == "radio_button"
                if value == "other"
                  response_array << response.first.last["other"] if value != "" && key != "other"
                else
                  response_array << value if value != "" && key != "other"
                end 
              elsif ["ranking", "radio_button_scale"].include?(question_type)
                response_array << key+": "+value if value != "" && key != "other"
              elsif ["checkbox_grid", "textbox_grid", "radio_button_grid"].include?(question_type)
                response_array_value  = []
                value.each do |value_key, value_value|
                  response_array_value << value_key+": "+value_value if value_value != ""
                end
                response_array << response_array_value.join(",")
              else
                response_array << key if value != "" && key != "other"
              end
            end
          end
          # p response_array.join(", ")
          response_question.answer = response_array.join(", ")
        else
          # p response.first.last
          response_question.answer = response.first.last  
        end
        p "=================="

        response_question.save
      end

    end
    
    redirect_to reset_session_surveys_path
  end

  def init_survey
    set_value(params, params[:id])

    redirect_to survey_path(params[:id], page: params[:pages][:next])
  end

  private
    def set_value(params, question_id)
      session[current_user.id.to_s]['response'][question_id] = {} unless session[current_user.id.to_s]['response'][params[:id]].present?
      if params[:response].present?
        params[:response].each do |id, responses|
          session[current_user.id.to_s]['response'][question_id][id] = responses 
        end
      end
    end

    def survey_params
      params.require(:survey).permit(:name, :description, :period_start, :period_end, :status, :back_page_url, :disclaimer, :user_id)
    end

    def change_format(date)
    	dates = date.split("/")
    	return dates[2] + "-" + dates[0] + "-" + dates[1]
    end
end
