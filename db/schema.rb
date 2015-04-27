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

ActiveRecord::Schema.define(version: 20150408145200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreement_ratings", primary_key: "agreement_rating_id", force: true do |t|
    t.text "agreement_rating", null: false
  end

  add_index "agreement_ratings", ["agreement_rating"], name: "agreement_ratings__u_agreement_rating", unique: true, using: :btree

  create_table "ethnicities", primary_key: "ethnicity_id", force: true do |t|
    t.text "ethnicity", null: false
  end

  add_index "ethnicities", ["ethnicity"], name: "ethnicities__u_ethnicity", unique: true, using: :btree

  create_table "genders", primary_key: "gender_id", force: true do |t|
    t.text "gender", null: false
  end

  add_index "genders", ["gender"], name: "genders__u_gender", unique: true, using: :btree

  create_table "submissions", force: true do |t|
    t.integer  "survey_response_id", null: false
    t.integer  "step_id",            null: false
    t.integer  "action_id",          null: false
    t.json     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submissions", ["action_id"], name: "index_submissions_on_action_id", using: :btree
  add_index "submissions", ["step_id"], name: "index_submissions_on_step_id", using: :btree
  add_index "submissions", ["survey_response_id"], name: "index_submissions_on_survey_response_id", using: :btree

  create_table "survey_actions", primary_key: "survey_action_id", force: true do |t|
    t.text "survey_action", null: false
  end

  add_index "survey_actions", ["survey_action"], name: "survey_actions__u_survey_action", unique: true, using: :btree

  create_table "survey_question_agreement_rating_responses", force: true do |t|
    t.integer  "survey_step_response_id", null: false
    t.integer  "question_id",             null: false
    t.integer  "response_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_question_agreement_rating_responses", ["question_id"], name: "index_survey_question_agreement_rating_responses_on_question_id", using: :btree

  create_table "survey_question_select_yes_no_responses", force: true do |t|
    t.integer  "survey_step_response_id", null: false
    t.integer  "question_id",             null: false
    t.boolean  "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_question_select_yes_no_responses", ["question_id"], name: "index_survey_question_select_yes_no_responses_on_question_id", using: :btree

  create_table "survey_question_string_responses", force: true do |t|
    t.integer  "survey_step_response_id", null: false
    t.integer  "question_id",             null: false
    t.string   "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_question_string_responses", ["question_id"], name: "index_survey_question_string_responses_on_question_id", using: :btree

  create_table "survey_question_types", force: true do |t|
    t.string   "response_type",  null: false
    t.string   "response_class", null: false
    t.string   "question_view",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", force: true do |t|
    t.integer  "survey_step_id",   null: false
    t.integer  "question_type_id", null: false
    t.string   "name",             null: false
    t.text     "question",         null: false
    t.integer  "sequence",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_questions", ["survey_step_id", "name"], name: "index_survey_questions_on_survey_step_id_and_name", unique: true, using: :btree
  add_index "survey_questions", ["survey_step_id", "sequence"], name: "index_survey_questions_on_survey_step_id_and_sequence", unique: true, using: :btree
  add_index "survey_questions", ["survey_step_id"], name: "index_survey_questions_on_survey_step_id", using: :btree

  create_table "survey_responses", force: true do |t|
    t.integer  "survey_type_id", null: false
    t.integer  "user_id"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_responses", ["survey_type_id"], name: "index_survey_responses_on_survey_type_id", using: :btree
  add_index "survey_responses", ["user_id"], name: "index_survey_responses_on_user_id", using: :btree

  create_table "survey_step_responses", force: true do |t|
    t.integer  "survey_response_id", null: false
    t.integer  "step_id",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_step_responses", ["step_id"], name: "index_survey_step_responses_on_step_id", using: :btree
  add_index "survey_step_responses", ["survey_response_id"], name: "index_survey_step_responses_on_survey_response_id", using: :btree

  create_table "survey_steps", force: true do |t|
    t.integer  "survey_type_id", null: false
    t.string   "name",           null: false
    t.text     "intro"
    t.string   "custom_action"
    t.integer  "next_step_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_steps", ["survey_type_id"], name: "index_survey_steps_on_survey_type_id", using: :btree

  create_table "survey_types", force: true do |t|
    t.string   "survey_type",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "starting_step_id"
  end

  add_index "survey_types", ["starting_step_id"], name: "index_survey_types_on_starting_step_id", using: :btree

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

end
