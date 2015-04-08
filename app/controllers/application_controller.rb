class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_survey_response

  def init_survey_response(survey_type)
    survey_response = SurveyResponse.create(survey_type: survey_type)
    session[:survey] = survey_response.id if survey_response
    return survey_response
  end

  def current_survey_response
    if !session[:survey].blank?
      return SurveyResponse.find(session[:survey])
    else
      return nil
    end
  end

  def new_patient?
    survey_response = current_survey_response
    return survey_response && (survey_response.survey_type == :new_patient)
  end

  def returning_patient?
    survey_response = current_survey_response
    return survey_response && (survey_response.survey_type == :returning_patient)
  end

  def current_user
    survey_response = current_survey_response
    return survey_response && survey_response.user
  end

  def record_submission(step, action, params)
    survey_response = current_survey_response
    return if !survey_response

    submission_attrs = {
      survey_response: survey_response,
      submission_step: SubmissionStep[step],
      submission_action: SubmissionAction[action],
      params: params
    }

    logger.debug("Recording submission: #{submission_attrs.inspect()}")

    begin
      Submission.create!(submission_attrs)
      return true;
    rescue Exception => e
      logger.warn "Failed to record submission: #{submission_attrs.inspect()}\n  Error: #{e.inspect()}"
    end

    return false;
  end

  def cancel_submission
      reset_session
      redirect_to root_path
  end

private

  def require_survey_response
    if !current_survey_response
      logger.warn "Request received without survey response -- request URL: #{request.url}, params: #{params.inspect()}"
      redirect_to root_path
    end
  end

end
