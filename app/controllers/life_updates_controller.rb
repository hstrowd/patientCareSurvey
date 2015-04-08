class LifeUpdatesController < ApplicationController
  def new
    @life_update = current_survey_response.life_update
    if !@life_update
      @life_update = LifeUpdate.new
    end
  end

  def create
    record_submission(:new_life_update, params[:step], life_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      redirect_to new_work_update_path
    else
      @life_update = LifeUpdate.new(life_update_params)
      @life_update.survey_response = current_survey_response

      if !@life_update.save
        render :new
        return
      end

      redirect_to new_health_update_path
    end
  end

  def update
    record_submission(:change_life_update, params[:step], life_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      redirect_to new_work_update_path
    else
      @life_update = LifeUpdate.find(params[:id])
      if !@life_update
        @life_update = LifeUpdate.new
        @life_update.survey_response = current_survey_response
      end
      @life_update.update(life_update_params)

      if !@life_update.save
        render :new
        return
      end

      redirect_to new_health_update_path
    end
  end

private

  def life_update_params
    begin
      params.require(:life_update)
        .permit(:depressed_rating,
                :hope_rating,
                :spiritual_rating,
                :support_sources)
    rescue ActionController::ParameterMissing => e
      logger.info "Failed to parse life update params from #{params.inspect}"
      {}
    end
  end

end
