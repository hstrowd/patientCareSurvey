class WorkUpdatesController < ApplicationController
  def new
    @work_update = current_survey_response.work_update
    if !@work_update
      @work_update = WorkUpdate.new
    end
  end

  def create
    record_submission(:new_work_update, params[:step], work_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      redirect_to new_tumor_update_path
    else
      @work_update = WorkUpdate.new(work_update_params)
      @work_update.survey_response = current_survey_response

      if !@work_update.save
        render :new
        return
      end

      redirect_to new_life_update_path
    end
  end

  def update
    record_submission(:change_work_update, params[:step], work_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      redirect_to new_tumor_update_path
    else
      @work_update = WorkUpdate.find(params[:id])
      if !@work_update
        @work_update = WorkUpdate.new
        @work_update.survey_response = current_survey_response
      end
      @work_update.update(work_update_params)

      if !@work_update.save
        render :new
        return
      end

      redirect_to new_life_update_path
    end
  end

private

  def work_update_params
    begin
      params.require(:work_update)
        .permit(:prior_employment_status,
                :current_employment_status,
                :max_education_level)
    rescue ActionController::ParameterMissing => e
      logger.info "Failed to parse work update params from #{params.inspect}"
      {}
    end
  end

end
