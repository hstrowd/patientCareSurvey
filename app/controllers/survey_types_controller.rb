class SurveyTypesController < ApplicationController
  skip_before_action :require_survey_response

  def show
    survey_type = SurveyType.find_by_id(params[:id])

    if !survey_type
      flash[:alert] = "Failed to find requested survey. Please try again."
      redirect_to root_path
      return
    end

    if !survey_type.starting_step
      flash[:alert] = "Invalid survey configuration. Please try again."
      redirect_to root_path
      return
    end

    init_survey_response(survey_type)

    step = survey_type.starting_step
    redirect_to_step(step)
  end

end
