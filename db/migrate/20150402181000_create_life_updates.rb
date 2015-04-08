class CreateLifeUpdates < ActiveRecord::Migration
  def change
    create_lookup_table :agreement_ratings, small: true
    create_lookup_table :support_sources

    create_table(:life_updates) do |t|
      t.belongs_to :survey_response, null: false

      t.belongs_to :depressed_rating
      t.belongs_to :hope_rating
      t.belongs_to :spiritual_rating

      t.timestamps
    end

    add_index :life_updates, :survey_response_id

    create_table(:life_update_support_sources) do |t|
      t.belongs_to :life_update
      t.belongs_to :support_source
    end

    add_index :life_update_support_sources, :life_update_id
  end
end
