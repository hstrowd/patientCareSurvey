class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table(:survey_types) do |t|
      t.string :survey_type,       null: false

      t.timestamps
    end


    create_table(:survey_responses) do |t|
      t.belongs_to :survey_type, null: false
      t.belongs_to :user
      t.boolean :completed

      t.timestamps
    end

    add_index :survey_responses, :survey_type_id
    add_index :survey_responses, :user_id
  end
end
