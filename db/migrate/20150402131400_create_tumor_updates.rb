class CreateTumorUpdates < ActiveRecord::Migration
  def change
    create_table(:tumor_updates) do |t|
      t.belongs_to :survey_response, null: false

      t.text    :diagnosis
      t.boolean :has_had_surgery
      t.boolean :has_had_radiation
      t.boolean :has_had_chemo
      t.string  :chemo_type
      t.boolean :has_had_seizure
      t.integer :seizure_count
      t.integer :steroid_dose
      t.boolean :unknown_steroid_dose

      t.timestamps
    end

    add_index :tumor_updates, :survey_response_id
  end
end
