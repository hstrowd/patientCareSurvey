class HomeController < ApplicationController
  skip_before_action :require_survey_response, only: [:index, :thank_you]

  def index
    @new_patient = SurveyType.find_by_survey_type(:new_patient)
    @returning_patient = SurveyType.find_by_survey_type(:returning_patient)
  end
end
