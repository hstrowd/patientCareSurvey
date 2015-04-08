class HealthUpdatesController < ApplicationController
  def new
    @health_update = current_survey_response.health_update
    if !@health_update
      @health_update = HealthUpdate.new
    end
  end

  def create
    record_submission(:new_health_update, params[:step], health_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      redirect_to new_life_update_path
    else
      @health_update = HealthUpdate.new(health_update_params)
      @health_update.survey_response = current_survey_response

      if !@health_update.save
        render :new
        return
      end

      survey_response = current_survey_response
      survey_response.completed = true
      survey_response.save!

      reset_session

      redirect_to thank_you_path
    end
  end

  def update
    record_submission(:change_health_update, params[:step], health_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      redirect_to new_life_update_path
    else
      @health_update = HealthUpdate.find(params[:id])
      if !@health_update
        @health_update = HealthUpdate.new
        @health_update.survey_response = current_survey_response
      end
      @health_update.update(health_update_params)

      if !@health_update.save
        render :new
        return
      end

      survey_response = current_survey_response
      survey_response.completed = true
      survey_response.save!

      reset_session

      redirect_to thank_you_path
    end
  end

private

  def health_update_params
    begin
      params.require(:health_update)
        .permit(:headache,
                :weakness,
                :speech_problems,
                :memory_problems,
                :anxiousness,
                :concentration_problems,
                :sleep_problems)
    rescue ActionController::ParameterMissing => e
      logger.info "Failed to parse life update params from #{params.inspect}"
      {}
    end
  end

end
