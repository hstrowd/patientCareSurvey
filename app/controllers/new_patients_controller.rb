class NewPatientsController < ApplicationController
  def submit_personal_details
    redirect_to new_patient_tumor_path
  end

  def submit_tumor_details
    redirect_to new_patient_work_path
  end

  def submit_work_details
    redirect_to new_patient_life_path
  end

  def submit_life_details
    redirect_to new_patient_health_path
  end

  def submit_health_details
    redirect_to thank_you_path
  end
end
