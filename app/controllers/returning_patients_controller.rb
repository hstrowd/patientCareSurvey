class ReturningPatientsController < ApplicationController
  def submit_personal_details
    if (params[:commit] == 'Cancel')
      redirect_to root_path
    elsif (params[:commit] == 'Back')
      redirect_to root_path
    else
      # Default to 'Next'
      redirect_to returning_patient_health_path
    end
  end

  def submit_health_details
    if (params[:commit] == 'Cancel')
      redirect_to root_path
    elsif (params[:commit] == 'Back')
      redirect_to returning_patient_personal_path
    else
      # Default to 'Next'
      redirect_to thank_you_path
    end
  end
end
