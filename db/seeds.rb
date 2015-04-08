# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Gender.seed *%w[male female other]
Ethnicity.seed *%w[american_indian asian hispanic african_american pacific_islander white other]

SurveyType.seed *%w[new_patient returning_patient]

SubmissionStep.seed *%w[new_user lookup_user change_user new_tumor_update change_tumor_update new_work_update change_work_update new_life_update change_life_update new_health_update change_health_update]
SubmissionAction.seed *%w[submit back cancel timeout]

AgreementRating.seed *%w[strong_agree agree neutral disagree strong_disagree]
SupportSource.seed *%w[self family friend religion other]

EmploymentStatus.seed *%w[full part none]
EducationLevel.seed *%w[high_school vocational associate bachelor master doc none]
