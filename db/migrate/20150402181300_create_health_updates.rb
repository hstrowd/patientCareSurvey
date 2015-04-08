class CreateHealthUpdates < ActiveRecord::Migration
  def change
    create_table(:health_updates) do |t|
      t.belongs_to :survey_response, null: false

      t.boolean :headache
      t.boolean :weakness
      t.boolean :speech_problems
      t.boolean :memory_problems
      t.boolean :anxiousness
      t.boolean :concentration_problems
      t.boolean :sleep_problems

      t.timestamps
    end

    add_index :health_updates, :survey_response_id
  end
end
