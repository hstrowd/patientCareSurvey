class UsersController < ApplicationController

  def new
    @user = current_survey_response.user || User.new
  end

  def create
    step = SurveyStep.find_by_name(:create_user)
    if !step
      logger.error("Unable to find create_user step.")

      flash.now[:alert] = "Configuration error detected."
      redirect_to root_path
      return
    end

    process_step_response(step, params[:next_action]) do
      @user = User.new
      return if !update_user(user_params)

      survey_response = current_survey_response
      survey_response.user = @user
      survey_response.save!
    end
  end

  def update
    step = SurveyStep.find_by_name(:create_user)
    if !step
      logger.error("Unable to find create_user step.")

      flash.now[:alert] = "Configuration error detected."
      redirect_to root_path
      return
    end

    process_step_response(step, params[:next_action]) do
      @user = User.new
      return if !update_user(user_params)

      survey_response = current_survey_response
      survey_response.user = @user
      survey_response.save!
    end
  end

  def new_lookup
    @user = current_survey_response.user || User.new
  end

  def lookup
    step = SurveyStep.find_by_name(:lookup_user)
    if !step
      logger.error("Unable to find lookup_user step.")

      flash.now[:alert] = "Configuration error detected."
      redirect_to root_path
      return
    end

    process_step_response(step, params[:next_action]) do
      if !user_params[:first_name] ||
          !user_params[:last_name] ||
          !user_params[:birth_date]
        flash.now[:alert] = "Missing required fields."
        @user = User.new(user_params)
        render :new_lookup
        return
      end

      # Note: Using lower here prevents us from using our indexes.
      users = User.where("lower(first_name) = lower(?) AND lower(last_name) = lower(?) AND birth_date = ?",
                         user_params[:first_name],
                         user_params[:last_name],
                         user_params[:birth_date])

      if users.empty?
        flash.now[:notice] = "No matching user found."
        @user = User.new(user_params)
        render :new_lookup
        return
      end

      @user = users.first
      survey_response = current_survey_response
      survey_response.user = @user
      survey_response.save!

      if users.size > 1
        render :duplicate_check
        return
      end
    end
  end

  def duplicate
    if new_patient?
      step_key = :duplicate_user
    else
      step_key = :multiple_users
    end
    step = SurveyStep.find_by_name(step_key)
    if !step
      logger.warn("Unable to find #{step_key} step.")

      flash.now[:alert] = "Configuration error detected."
      redirect_to root_path
      return
    end

    process_step_response(step, params[:next_action]) do
      if !duplicate_check_params[:duplicate_user_id].blank?
        return if !lookup_duplicate(duplicate_check_params[:duplicate_user_id])
      else
        if new_patient?
          user_attrs = session[:pending_user_attrs]
          user_attrs.delete('id')

          @user = User.new
          return if !update_user(user_attrs, check_dup: false)
        else
          flash.now[:alert] = "A previous account is required for returning patients."
          redirect_to lookup_users_path
          return
        end
      end
      session[:pending_user_attrs] = nil

      survey_response = current_survey_response
      survey_response.user = @user
      survey_response.save!
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

    logger.debug("Succesfully created new User.")
    return true
  end

end
