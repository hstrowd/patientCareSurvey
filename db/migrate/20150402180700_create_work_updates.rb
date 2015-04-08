class CreateWorkUpdates < ActiveRecord::Migration
  def change
    create_lookup_table :employment_statuses, small: true
    create_lookup_table :education_levels, small: true

    create_table(:work_updates) do |t|
      t.belongs_to :survey_response, null: false

      t.belongs_to :prior_employment_status
      t.belongs_to :current_employment_status
      t.belongs_to :max_education_level

      t.timestamps
    end

    add_index :work_updates, :survey_response_id
  end
end
