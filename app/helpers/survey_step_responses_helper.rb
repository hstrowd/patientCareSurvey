module SurveyStepResponsesHelper

  def lookup_question_response(step_response, question)
    return nil if !step_response || !question

    question_response_class = question.question_type.response_class.constantize
    return question_response_class.where(survey_step_response: step_response, question: question).first
  end

end
