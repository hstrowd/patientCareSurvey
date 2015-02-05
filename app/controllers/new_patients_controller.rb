class NewPatientsController < ApplicationController
  def submit_personal_details
    if (params[:step] == 'cancel')
      redirect_to root_path
    elsif (params[:step] == 'back')
      redirect_to root_path
    else
      # Default to 'Next'
      redirect_to new_patient_tumor_path
    end
  end

  def submit_tumor_details
    if (params[:step] == 'cancel')
      redirect_to root_path
    elsif (params[:step] == 'back')
      redirect_to new_patient_personal_path
    else
      # Default to 'Next'
      redirect_to new_patient_work_path
    end
  end

  def submit_work_details
    if (params[:step] == 'cancel')
      redirect_to root_path
    elsif (params[:step] == 'back')
      redirect_to new_patient_tumor_path
    else
      # Default to 'Next'
      redirect_to new_patient_life_path
    end
  end

  def submit_life_details
    if (params[:step] == 'cancel')
      redirect_to root_path
    elsif (params[:step] == 'back')
      redirect_to new_patient_work_path
    else
      # Default to 'Next'
      redirect_to new_patient_health_path
    end
  end

  def submit_health_details
    if (params[:step] == 'cancel')
      redirect_to root_path
    elsif (params[:step] == 'back')
      redirect_to new_patient_life_path
    else
      # Default to 'Next'
      redirect_to thank_you_path
    end
  end
end
