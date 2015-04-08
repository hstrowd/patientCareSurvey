# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150402181300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreement_ratings", primary_key: "agreement_rating_id", force: true do |t|
    t.text "agreement_rating", null: false
  end

  add_index "agreement_ratings", ["agreement_rating"], name: "agreement_ratings__u_agreement_rating", unique: true, using: :btree

  create_table "education_levels", primary_key: "education_level_id", force: true do |t|
    t.text "education_level", null: false
  end

  add_index "education_levels", ["education_level"], name: "education_levels__u_education_level", unique: true, using: :btree

  create_table "employment_statuses", primary_key: "employment_status_id", force: true do |t|
    t.text "employment_status", null: false
  end

  add_index "employment_statuses", ["employment_status"], name: "employment_statuses__u_employment_status", unique: true, using: :btree

  create_table "ethnicities", primary_key: "ethnicity_id", force: true do |t|
    t.text "ethnicity", null: false
  end

  add_index "ethnicities", ["ethnicity"], name: "ethnicities__u_ethnicity", unique: true, using: :btree

  create_table "genders", primary_key: "gender_id", force: true do |t|
    t.text "gender", null: false
  end

  add_index "genders", ["gender"], name: "genders__u_gender", unique: true, using: :btree

  create_table "health_updates", force: true do |t|
    t.integer  "survey_response_id",     null: false
    t.boolean  "headache"
    t.boolean  "weakness"
    t.boolean  "speech_problems"
    t.boolean  "memory_problems"
    t.boolean  "anxiousness"
    t.boolean  "concentration_problems"
    t.boolean  "sleep_problems"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "health_updates", ["survey_response_id"], name: "index_health_updates_on_survey_response_id", using: :btree

  create_table "life_update_support_sources", force: true do |t|
    t.integer "life_update_id"
    t.integer "support_source_id"
  end

  add_index "life_update_support_sources", ["life_update_id"], name: "index_life_update_support_sources_on_life_update_id", using: :btree

  create_table "life_updates", force: true do |t|
    t.integer  "survey_response_id",  null: false
    t.integer  "depressed_rating_id"
    t.integer  "hope_rating_id"
    t.integer  "spiritual_rating_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "life_updates", ["survey_response_id"], name: "index_life_updates_on_survey_response_id", using: :btree

  create_table "submission_actions", primary_key: "submission_action_id", force: true do |t|
    t.text "submission_action", null: false
  end

  add_index "submission_actions", ["submission_action"], name: "submission_actions__u_submission_action", unique: true, using: :btree

  create_table "submission_steps", primary_key: "submission_step_id", force: true do |t|
    t.text "submission_step", null: false
  end

  add_index "submission_steps", ["submission_step"], name: "submission_steps__u_submission_step", unique: true, using: :btree

  create_table "submissions", force: true do |t|
    t.integer  "survey_response_id",   null: false
    t.integer  "submission_step_id",   null: false
    t.integer  "submission_action_id", null: false
    t.json     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submissions", ["submission_action_id"], name: "index_submissions_on_submission_action_id", using: :btree
  add_index "submissions", ["submission_step_id"], name: "index_submissions_on_submission_step_id", using: :btree
  add_index "submissions", ["survey_response_id"], name: "index_submissions_on_survey_response_id", using: :btree

  create_table "support_sources", primary_key: "support_source_id", force: true do |t|
    t.text "support_source", null: false
  end

  add_index "support_sources", ["support_source"], name: "support_sources__u_support_source", unique: true, using: :btree

  create_table "survey_responses", force: true do |t|
    t.integer  "survey_type_id", null: false
    t.integer  "user_id"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_responses", ["survey_type_id"], name: "index_survey_responses_on_survey_type_id", using: :btree
  add_index "survey_responses", ["user_id"], name: "index_survey_responses_on_user_id", using: :btree

  create_table "survey_types", primary_key: "survey_type_id", force: true do |t|
    t.text "survey_type", null: false
  end

  add_index "survey_types", ["survey_type"], name: "survey_types__u_survey_type", unique: true, using: :btree

  create_table "tumor_updates", force: true do |t|
    t.integer  "survey_response_id",   null: false
    t.text     "diagnosis"
    t.boolean  "has_had_surgery"
    t.boolean  "has_had_radiation"
    t.boolean  "has_had_chemo"
    t.string   "chemo_type"
    t.boolean  "has_had_seizure"
    t.integer  "seizure_count"
    t.integer  "steroid_dose"
    t.boolean  "unknown_steroid_dose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tumor_updates", ["survey_response_id"], name: "index_tumor_updates_on_survey_response_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.date     "birth_date",      null: false
    t.integer  "gender_id"
    t.string   "gender_other"
    t.integer  "ethnicity_id"
    t.string   "ethnicity_other"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["first_name", "last_name", "birth_date"], name: "index_users_on_first_name_and_last_name_and_birth_date", using: :btree

  create_table "work_updates", force: true do |t|
    t.integer  "survey_response_id",           null: false
    t.integer  "prior_employment_status_id"
    t.integer  "current_employment_status_id"
    t.integer  "max_education_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "work_updates", ["survey_response_id"], name: "index_work_updates_on_survey_response_id", using: :btree

end
