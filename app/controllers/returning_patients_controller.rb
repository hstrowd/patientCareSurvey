class ReturningPatientsController < ApplicationController
  def submit_personal_details
  end

  def submit_health_details
    if (params[:step] == 'cancel')
      redirect_to root_path
    elsif (params[:step] == 'back')
      redirect_to returning_patient_personal_path
    else
      # Default to 'Next'
      redirect_to thank_you_path
    end
  end
end
