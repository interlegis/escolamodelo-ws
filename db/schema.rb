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

ActiveRecord::Schema.define(version: 2018_11_30_150741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "api_access_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_accesses", force: :cascade do |t|
    t.string "key", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "api_access_level_id"
    t.index ["api_access_level_id"], name: "index_api_accesses_on_api_access_level_id"
    t.index ["key"], name: "index_api_accesses_on_key", unique: true
    t.index ["user_id"], name: "index_api_accesses_on_user_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "certificates", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "issue_date"
    t.float "grade"
    t.string "code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_certificates_on_course_id"
    t.index ["user_id"], name: "index_certificates_on_user_id"
  end

  create_table "contact_us_conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "description"
    t.date "initial_date"
    t.string "school_initials"
    t.bigint "course_id"
    t.bigint "course_category_id"
    t.boolean "was_answered"
    t.string "type_conversation"
    t.string "cpf"
    t.string "name"
    t.string "email"
    t.bigint "school_id"
    t.bigint "user_id"
    t.index ["school_id"], name: "index_contact_us_conversations_on_school_id"
    t.index ["user_id"], name: "index_contact_us_conversations_on_user_id"
  end

  create_table "contact_us_messages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "cpf"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contact_us_conversation_id"
    t.boolean "is_student"
    t.index ["contact_us_conversation_id"], name: "index_contact_us_messages_on_contact_us_conversation_id"
  end

  create_table "course_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_registration_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_registrations", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_registration_status_id"
    t.index ["course_id"], name: "index_course_registrations_on_course_id"
    t.index ["course_registration_status_id"], name: "index_course_registrations_on_course_registration_status_id"
    t.index ["user_id"], name: "index_course_registrations_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_category_id"
    t.bigint "school_id"
    t.string "url"
    t.integer "course_load"
    t.text "description"
    t.integer "ead_id"
    t.string "certificador"
    t.string "conteudista"
    t.integer "carga_horaria"
    t.string "status"
    t.boolean "visible"
    t.index ["course_category_id"], name: "index_courses_on_course_category_id"
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "oauth_openid_requests", force: :cascade do |t|
    t.integer "access_grant_id", null: false
    t.string "nonce", null: false
  end

  create_table "quiz_answers", force: :cascade do |t|
    t.string "answer"
    t.bigint "quiz_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_question_id"], name: "index_quiz_answers_on_quiz_question_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.text "question"
    t.bigint "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tag"
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "autor"
    t.string "cargo"
    t.string "cidade"
    t.string "uf"
    t.string "opiniao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "initials"
    t.index ["initials"], name: "index_schools_on_initials", unique: true
  end

  create_table "user_quiz_answers", force: :cascade do |t|
    t.bigint "course_registration_id"
    t.bigint "quiz_answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_registration_id"], name: "index_user_quiz_answers_on_course_registration_id"
    t.index ["quiz_answer_id"], name: "index_user_quiz_answers_on_quiz_answer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "cpf"
    t.string "first_name"
    t.string "last_name"
    t.date "birth"
    t.string "phone"
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string "last_login_from_ip_address"
    t.boolean "restriction", default: false
    t.index ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "api_accesses", "api_access_levels"
  add_foreign_key "api_accesses", "users"
  add_foreign_key "certificates", "courses"
  add_foreign_key "certificates", "users"
  add_foreign_key "contact_us_conversations", "schools"
  add_foreign_key "contact_us_conversations", "users"
  add_foreign_key "contact_us_messages", "contact_us_conversations"
  add_foreign_key "course_registrations", "course_registration_statuses"
  add_foreign_key "course_registrations", "courses"
  add_foreign_key "course_registrations", "users"
  add_foreign_key "courses", "course_categories"
  add_foreign_key "courses", "schools"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_openid_requests", "oauth_access_grants", column: "access_grant_id"
  add_foreign_key "quiz_answers", "quiz_questions"
  add_foreign_key "quiz_questions", "quizzes"
  add_foreign_key "user_quiz_answers", "course_registrations"
  add_foreign_key "user_quiz_answers", "quiz_answers"
  add_foreign_key "users", "roles"
end
