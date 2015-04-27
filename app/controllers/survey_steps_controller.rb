class SurveyStepsController < ApplicationController

  def show
    step_id = params[:id]
    @step = SurveyStep.find(step_id)

    if !@step
      # TODO: Add a flash message.
      redirect_to root_path
      return
    end

    render @step.custom_view if @step.custom_view
  end

end
