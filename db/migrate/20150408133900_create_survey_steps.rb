class CreateSurveySteps < ActiveRecord::Migration
  def change
    create_table(:survey_steps) do |t|
      t.belongs_to :survey_type, null: false
      t.string :name,            null: false
      t.text :intro
      t.string :custom_action

      t.belongs_to :next_step

      t.timestamps
    end

    add_index :survey_steps, :survey_type_id
    # Add a unique constraint for names within a survey type.


    add_reference :survey_types, :starting_step
    add_index :survey_types, :starting_step_id


    create_table(:survey_step_responses) do |t|
      t.belongs_to :survey_response, null: false
      t.belongs_to :step,            null: false

      t.timestamps
    end

    add_index :survey_step_responses, :survey_response_id
    add_index :survey_step_responses, :step_id
  end
end
