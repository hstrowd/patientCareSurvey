class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_survey_response


  def redirect_to_step(step)
    # If there is no next step, complete the survey.
    if !step
      redirect_to thank_you_path
      return
    end

    step_action = step.custom_action || new_survey_step_response_path(step)
    redirect_to step_action
  end


  def init_survey_response(survey_type)
    survey_response = SurveyResponse.create(survey_type: survey_type)
    session[:survey_response_id] = survey_response.id if survey_response
    return survey_response
  end

  def current_survey_response
    if !session[:survey_response_id].blank?
      return SurveyResponse.find(session[:survey_response_id])
    else
      return nil
    end
  end

  def new_patient?
    survey_response = current_survey_response
    return survey_response && (survey_response.survey_type.survey_type == 'new_patient')
  end

  def returning_patient?
    survey_response = current_survey_response
    return survey_response && (survey_response.survey_type.survey_type == 'returning_patient')
  end

  def record_submission(step, action, params)
    survey_response = current_survey_response
    if !survey_response
      logger.warn("Unable to record submission. No survey response found.\n  Step: #{step.try(:inspect)}\n  Params: #{params.try(:inspect)}")
      return
    end

    return if !action

    submission_attrs = {
      survey_response: survey_response,
      step: step,
      action: action,
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

  def process_step_response(step, action_key)
    action = SurveyAction[action_key]
    logger.warn("Unrecognized survey action: #{action_key}") if !action

    record_submission(step, action, params)

    if (action == SurveyAction[:cancel])
      cancel_survey_response && return
    elsif (action == SurveyAction[:back])
      if step.previous_step
        redirect_to_step(step.previous_step)
      else
        cancel_survey_response
      end
      return
    else
      yield

      redirect_to_step(step.next_step)
    end
  end

  def cancel_survey_response
      reset_session
      redirect_to root_path
  end

private

  def require_survey_response
    if !current_survey_response
      logger.warn "Request received without survey response -- request URL: #{request.url}, params: #{params.inspect()}"
      # TODO: Add a flash message here.
      redirect_to root_path
    end
  end

end
