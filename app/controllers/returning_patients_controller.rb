class ReturningPatientsController < ApplicationController
  def submitPersonalDetails
    redirect_to returning_patient_health_path
  end

  def submitHealthDetails
    redirect_to thank_you_path
  end
end
