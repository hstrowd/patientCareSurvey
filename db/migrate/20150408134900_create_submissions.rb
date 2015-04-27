class CreateSubmissions < ActiveRecord::Migration
  def change
    create_lookup_table :survey_actions, small: true

    create_table(:submissions) do |t|
      t.belongs_to :survey_response,   null: false
      t.belongs_to :step,              null: false
      t.belongs_to :action,            null: false
      t.json :params

      t.timestamps
    end

    add_index :submissions, :survey_response_id
    add_index :submissions, :step_id
    add_index :submissions, :action_id
  end
end
