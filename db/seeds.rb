# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Gender.seed *%w[male female other]
Ethnicity.seed *%w[american_indian asian hispanic african_american pacific_islander white other]

SurveyAction.seed *%w[submit back cancel timeout]

AgreementRating.seed *%w[strong_agree agree neutral disagree strong_disagree]

stringType          = SurveyQuestionType.create!(
  response_type:  'string',
  response_class: 'SurveyQuestionStringResponse',
  question_view:  'survey_questions/string'
  );
selectYesNoType     = SurveyQuestionType.create!(
  response_type: 'boolean',
  response_class: 'SurveyQuestionSelectYesNoResponse',
  question_view:  'survey_questions/select_yes_no'
  );
agreementRatingType = SurveyQuestionType.create!(
  response_type: 'agreement_rating',
  response_class: 'SurveyQuestionAgreementRatingResponse',
  question_view:  'survey_questions/agreement_rating'
  );
# TODO: Add a textarea question type.
# TODO: Add an employment type question type.
# TODO: Add an education level question type.



surveys = {
  new_patient: {
    steps: [{
        name: :create_user,
        custom_action: '/users/new'
      }, {
        name: :tumor_info,
        intro: 'Please answer the following about your tumor:',
        questions: [{
            question_type: selectYesNoType,
            name: 'has_had_surgery',
            question: 'Have you undergone surgery for your tumor?'
          }, {
            question_type: selectYesNoType,
            name: 'has_had_radiation',
            question: 'Have you undergone radiation for your tumor?'
          }, {
            question_type: selectYesNoType,
            name: 'has_had_chemo',
            question: 'Have you undergone chemotherapy for your tumor?'
          }, {
            question_type: stringType,
            name: 'chemo_type',
            question: 'If you have had chemotherapy, what was it called?'
          }, {
            question_type: selectYesNoType,
            name: 'has_had_seizure',
            question: 'Have you ever had a seizure?'
          }, {
            question_type: stringType,
            name: 'seizure_count',
            question: 'How many seizures have you had in the past one month?'
          }, {
            question_type: stringType,
            name: 'steroid_dose',
            question: 'What is your current dose of steroids (dexamethasone)?'
          }]
      }, {
        name: :work_info,
        intro: 'Please answer the following about your life:',
        questions: [{
            question_type: stringType,
            name: 'prior_employment_status',
            question: 'What was your employment status prior to the diagnosis of your tumor (e.g. full time, part time, none, etc)?'
          }, {
            question_type: stringType,
            name: 'current_employment_status',
            question: 'What is your current employment status (e.g. full time, part time, none, etc)?'
          }, {
            question_type: stringType,
            name: 'max_education_level',
            question: 'What is the highest schooling you\'ve completed?'
          }]
      }, {
        name: :life_info,
        intro: 'Please answer the following about your life:',
        questions: [{
            question_type: agreementRatingType,
            name: 'depressed_rating',
            question: 'In the past week, I have spent more than half of the time feeling depressed:'
          }, {
            question_type: agreementRatingType,
            name: 'hope_rating',
            question: 'In the past week, I have spent more than half of the time feeling no hope:'
          }, {
            question_type: agreementRatingType,
            name: 'spiritual_rating',
            question: 'I consider myself a spiritual person:'
          }, {
            question_type: stringType,
            name: 'support_sources',
            question: 'I receive support from the following sources (e.g. myself, friends, family, religion, etc):'
          }]
      }, {
        name: :health_info,
        intro: 'Have you suffered the following in the past week:',
        questions: [{
            question_type: selectYesNoType,
            name: 'headache',
            question: 'Headache'
          }, {
            question_type: selectYesNoType,
            name: 'weakness',
            question: 'Weakness'
          }, {
            question_type: selectYesNoType,
            name: 'speech_problems',
            question: 'Problems with Speech'
          }, {
            question_type: selectYesNoType,
            name: 'memory_problems',
            question: 'Problems with Memory'
          }, {
            question_type: selectYesNoType,
            name: 'anxiousness',
            question: 'Anxiousness'
          }, {
            question_type: selectYesNoType,
            name: 'concentration_problems',
            question: 'Trouble Concentrating'
          }, {
            question_type: selectYesNoType,
            name: 'sleep_problems',
            question: 'Trouble Sleeping'
          }]
      }]
  },
  returning_patient: {
    steps: [{
        name: :lookup_user,
        custom_action: '/users/lookup'
      }, {
        name: :tumor_and_life_update,
        intro: 'Please answer the following questions:',
        questions: [{
            question_type: stringType,
            name: 'seizure_count',
            question: 'How many seizures have you had in the past one month?'
          }, {
            question_type: stringType,
            name: 'steroid_dose',
            question: 'What is your current dose of steroids (dexamethasone)?'
          }, {
            question_type: agreementRatingType,
            name: 'depressed_rating',
            question: 'In the past week, I have spent more than half of the time feeling depressed:'
          }, {
            question_type: agreementRatingType,
            name: 'hope_rating',
            question: 'In the past week, I have spent more than half of the time feeling no hope:'
          }, {
            question_type: agreementRatingType,
            name: 'spiritual_rating',
            question: 'I consider myself a spiritual person:'
          }, {
            question_type: stringType,
            name: 'support_sources',
            question: 'I receive support from the following sources (e.g. myself, friends, family, religion, etc):'
          }]
      }, {
        name: :health_update,
        intro: 'Have you suffered the following in the past week:',
        questions: [{
            question_type: selectYesNoType,
            name: 'headache',
            question: 'Headache'
          }, {
            question_type: selectYesNoType,
            name: 'weakness',
            question: 'Weakness'
          }, {
            question_type: selectYesNoType,
            name: 'speech_problems',
            question: 'Problems with Speech'
          }, {
            question_type: selectYesNoType,
            name: 'memory_problems',
            question: 'Problems with Memory'
          }, {
            question_type: selectYesNoType,
            name: 'anxiousness',
            question: 'Anxiousness'
          }, {
            question_type: selectYesNoType,
            name: 'concentration_problems',
            question: 'Trouble Concentrating'
          }, {
            question_type: selectYesNoType,
            name: 'sleep_problems',
            question: 'Trouble Sleeping'
          }]
      }]
  }
}





surveys.each do |survey_type, survey_config|
  survey_type = SurveyType.create!(survey_type: survey_type)

  previous_step = nil
  next_step = nil
  survey_config[:steps].each_with_index do |step_config, i|
    step_attrs = step_config.reject { |k,v| k == :questions }
    step_attrs = { survey_type: survey_type }.merge(step_attrs)
    step = SurveyStep.create!(step_attrs)

    if i == 0
      survey_type.starting_step = step
      survey_type.save!
    end

    questions = step_config[:questions]
    questions && questions.each_with_index do |question_config, question_index|
      question_attrs = {survey_step: step, sequence: (question_index + 1)}.merge(question_config)
      SurveyQuestion.create!(question_attrs)
    end

    if previous_step
      previous_step.next_step = step
      previous_step.save!
    end
    previous_step = step
  end
end




# Create the duplicate user and multiple user steps.
new_patient_survey = SurveyType.find_by_survey_type(:new_patient)
tumor_info_step = SurveyStep.find_by_name(:tumor_info)
SurveyStep.create!({
    name: :duplicate_user,
    survey_type: new_patient_survey,
    custom_action: '/users/duplicate',
    next_step: tumor_info_step
  });

returning_patient_survey = SurveyType.find_by_survey_type(:returning_patient)
tumor_update_step = SurveyStep.find_by_name(:tumor_and_life_update)
SurveyStep.create!({
    name: :multiple_users,
    survey_type: returning_patient_survey,
    custom_action: '/users/duplicate',
    next_step: tumor_update_step
  });
