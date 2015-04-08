class UsersController < ApplicationController
  skip_before_action :require_survey_response, only: [:new, :new_lookup]

  def new
    survey_response = current_survey_response || init_survey_response(:new_patient)

    @user = survey_response.user
    if !@user
      if !session[:pending_user_attrs].blank?
        @user = User.new(session[:pending_user_attrs])
      else
        @user = User.new
      end
    end
  end

  def create
    record_submission(:new_user, params[:step], user_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      cancel_submission && return
    else
      @user = User.new
      return if !update_user(user_params)

      survey_response = current_survey_response
      survey_response.user = @user
      survey_response.save!

      redirect_to new_tumor_update_path
    end
  end

  def update
    record_submission(:change_user, params[:step], user_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      cancel_submission && return
    else
      @user = User.find(params[:id]) || User.new
      return if !update_user(user_params)

      survey_response = current_survey_response
      survey_response.user = @user
      survey_response.save!

      redirect_to new_tumor_update_path
    end
  end

  def new_lookup
    survey_response = current_survey_response || init_survey_response(:returning_patient)
  end

  def lookup
    record_submission(:lookup_user, params[:step], user_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      cancel_submission && return
    else
      redirect_to new_health_update_path
    end
  end

  def duplicate
    record_submission(:duplicate_check, params[:step], duplicate_check_params)

    if (params[:step] == 'cancel')
      cancel_submission && return
    elsif (params[:step] == 'back')
      if returning_patient?
        redirect_to lookup_users_path
      else
        redirect_to new_user_path
      end
    else
      if !duplicate_check_params[:duplicate_user_id].blank?
        return if !lookup_duplicate(duplicate_check_params[:duplicate_user_id])
      else
        user_attrs = session[:pending_user_attrs]
        user_attrs.delete('id')

        @user = User.new
        return if !update_user(user_attrs, check_dup: false)
      end
      session[:pending_user_attrs] = nil

      survey_response = current_survey_response
      survey_response.user = @user
      survey_response.save!

      if returning_patient?
        redirect_to new_health_update_path
      else
        redirect_to new_tumor_update_path
      end
    end
  end

private

  def user_params
    begin
      params.require(:user)
        .permit(:first_name,
                :last_name,
                :birth_date,
                :gender,
                :gender_other,
                :ethnicity,
                :ethnicity_other)
    rescue ActionController::ParameterMissing => e
      logger.info "Failed to parse user params from #{params.inspect}"
      {}
    end
  end

  def duplicate_check_params
    begin
      params
        .permit(:duplicate_user_id)
    rescue ActionController::ParameterMissing => e
      logger.info "Failed to parse duplicate check params from #{params.inspect}"
      {}
    end
  end

  def lookup_duplicate(user_id)
    @user = User.find(user_id)

    if !@user
      redirect_to new_user_path
      return false
    end

    return true
  end

  def update_user(user_attrs, opts = {})
    logger.debug "Creating new User with attributes: #{user_attrs.inspect()}"

    opts = {check_dup: true}.merge(opts)

    if user_attrs.blank?
      redirect_to new_user_path
      return false
    end

    @user.assign_attributes(user_attrs)

    # Make sure this is a valid request before entering the duplicate workflow.
    if !@user.valid?
      render :new
      return false
    end

    # Check if this is a duplicate user.
    if opts[:check_dup] && @user.duplicate?
      session[:pending_user_attrs] = @user.attributes
      render :duplicate_check
      return false
    end

    if !@user.save
      redirect_to new_user_path
      return false
    end

    logger.debug "Succesfully created new User."
    return true
  end

end
