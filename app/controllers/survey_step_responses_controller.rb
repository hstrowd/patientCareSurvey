class SurveyStepResponsesController < ApplicationController
  before_action :lookup_step

  def new
    @response = current_survey_response.step_responses.where(step: @step).first ||
      SurveyStepResponse.new(step: @step)
  end

  def create
    process_step_response(@step, params[:next_action]) do
      survey_response = current_survey_response
      step_response = survey_response.step_responses.where(step: @step).first ||
        SurveyStepResponse.new(survey_response: survey_response, step: @step)

      if !step_response.save
        logger.warn("Unable to create survey step response to step #{@step.id} for survey response #{survey_response.id}.")

        flash[:alert] = "Failed to save response."
        redirect_to new_survey_step_response_path(@step)
        return
      end

      record_response(step_response, params)
    end
  end

  def update
    process_step_response(@step, params[:next_action]) do
      step_response = SurveyStepResponse.find(params[:id])

      if !step_response
        logger.warn("Unable to find survey step response #{params[:id]}.")

        flash[:alert] = "Failed to save response."
        redirect_to new_survey_step_response_path(@step)
        return
      end

      record_response(step_response, params)
    end
  end

private

  def lookup_step
    step_id = params[:survey_step_id]
    @step = SurveyStep.find(step_id)

    if !@step
      # TODO: Add a flash message.
      redirect_to root_path
      return false
    end
  end

  def record_response(step_response, params)
    step_response.step.questions.each do |question|
      question_response_class = question.question_type.response_class.constantize

      question_response = question_response_class.where(survey_step_response: step_response, question: question).first
      if !question_response
        question_response = question_response_class.new(survey_step_response: step_response, question: question)
      end

      user_input = params[question.name]
      question_response.record(user_input)
      if !question_response.save
        logger.error("Failed to save response to #{question.name} question: #{user_input}")
      end
    end
  end

end
