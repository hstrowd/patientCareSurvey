class TumorUpdatesController < ApplicationController
  def new
    @tumor_update = current_survey_response.tumor_update
    if !@tumor_update
      @tumor_update = TumorUpdate.new
    end
  end

  def create
    record_submission(:new_tumor_update, params[:step], tumor_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      if returning_patient?
        redirect_to lookup_users_path
      else
        redirect_to new_user_path
      end
    else
      @tumor_update = TumorUpdate.new(tumor_update_params)
      @tumor_update.survey_response = current_survey_response

      if !@tumor_update.save
        render :new
        return
      end

      redirect_to new_work_update_path
    end
  end

  def update
    record_submission(:change_tumor_update, params[:step], tumor_update_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      if returning_patient?
        redirect_to lookup_users_path
      else
        redirect_to new_user_path
      end
    else
      @tumor_update = TumorUpdate.find(params[:id])
      if !@tumor_update
        @tumor_update = TumorUpdate.new
        @tumor_update.survey_response = current_survey_response
      end
      @tumor_update.update(tumor_update_params)

      if !@tumor_update.save
        render :new
        return
      end

      redirect_to new_work_update_path
    end
  end

private

  def tumor_update_params
    begin
      params.require(:tumor_update)
        .permit(:diagnosis,
                :has_had_surgery,
                :has_had_radiation,
                :has_had_chemo,
                :chemo_type,
                :has_had_seizure,
                :seizure_count,
                :steroid_dose,
                :unknown_steroid_dose)
    rescue ActionController::ParameterMissing => e
      logger.info "Failed to parse tumor update params from #{params.inspect}"
      {}
    end
  end

end
