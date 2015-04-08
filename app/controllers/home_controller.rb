class HomeController < ApplicationController
  skip_before_action :require_survey_response, only: [:index, :thank_you]
end
