class CreateSubmissions < ActiveRecord::Migration
  def change
    create_lookup_table :survey_types, small: true

    create_table(:survey_responses) do |t|
      t.belongs_to :survey_type, null: false
      t.belongs_to :user
      t.boolean :completed

      t.timestamps
    end

    add_index :survey_responses, :survey_type_id
    add_index :survey_responses, :user_id

    create_lookup_table :submission_steps,   small: true
    create_lookup_table :submission_actions, small: true

    create_table(:submissions) do |t|
      t.belongs_to :survey_response,   null: false
      t.belongs_to :submission_step,   null: false
      t.belongs_to :submission_action, null: false
      t.json :params

      t.timestamps
    end

    add_index :submissions, :survey_response_id
    add_index :submissions, :submission_step_id
    add_index :submissions, :submission_action_id
  end
end
