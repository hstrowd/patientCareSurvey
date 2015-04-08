class CreateUsers < ActiveRecord::Migration
  def change
    create_lookup_table :genders,     small: true
    create_lookup_table :ethnicities, small: true

    create_table(:users) do |t|
      t.string :first_name,  null: false
      t.string :last_name,   null: false
      t.date :birth_date,    null: false

      t.belongs_to :gender
      t.string :gender_other
      t.belongs_to :ethnicity
      t.string :ethnicity_other

      t.timestamps
    end

    add_index :users, [:first_name, :last_name, :birth_date], unique: false
  end
end
