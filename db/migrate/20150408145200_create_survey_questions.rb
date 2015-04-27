class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table(:survey_question_types) do |t|
      t.string :response_type,  null: false
      t.string :response_class, null: false
      t.string :question_view,  null: false

      t.timestamps
    end


    create_table(:survey_questions) do |t|
      t.belongs_to :survey_step,   null: false
      t.belongs_to :question_type, null: false
      t.string :name,              null: false
      t.text :question,            null: false
      t.integer :sequence,         null: false

      t.timestamps
    end

    add_index :survey_questions, :survey_step_id
    add_index :survey_questions, [:survey_step_id, :name], :unique => true
    add_index :survey_questions, [:survey_step_id, :sequence], :unique => true


    create_table(:survey_question_string_responses) do |t|
      t.belongs_to :survey_step_response, null: false
      t.belongs_to :question,             null: false
      t.string :response

      t.timestamps
    end

    # TODO: These index names are too long. Find a way to fix this.
    # add_index :survey_question_string_responses, :survey_step_response_id
    add_index :survey_question_string_responses, :question_id


    create_table(:survey_question_select_yes_no_responses) do |t|
      t.belongs_to :survey_step_response, null: false
      t.belongs_to :question,             null: false
      t.boolean :response

      t.timestamps
    end

    # add_index :survey_question_select_yes_no_responses, :survey_step_response_id
    add_index :survey_question_select_yes_no_responses, :question_id


    create_lookup_table :agreement_ratings, small: true

    create_table(:survey_question_agreement_rating_responses) do |t|
      t.belongs_to :survey_step_response, null: false
      t.belongs_to :question,             null: false
      t.belongs_to :response

      t.timestamps
    end

    # add_index :survey_question_agreement_rating_responses, :survey_step_response_id
    add_index :survey_question_agreement_rating_responses, :question_id
  end
end
