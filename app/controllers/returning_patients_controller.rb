class ReturningPatientsController < ApplicationController
  def submit_personal_details
    redirect_to returning_patient_health_path
  end

  def submit_health_details
    redirect_to thank_you_path
  end
end
