# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_928_015_709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'items', force: :cascade do |t|
    t.string 'description'
    t.bigint 'note_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['note_id'], name: 'index_items_on_note_id'
  end

  create_table 'labels', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'labels_notes', id: false, force: :cascade do |t|
    t.bigint 'note_id', null: false
    t.bigint 'label_id', null: false
    t.index %w[label_id note_id], name: 'index_labels_notes_on_label_id_and_note_id'
    t.index %w[note_id label_id], name: 'index_labels_notes_on_note_id_and_label_id'
  end

  create_table 'notes', force: :cascade do |t|
    t.string 'title'
    t.text 'content'
    t.string 'color'
    t.boolean 'archived'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_notes_on_user_id'
  end

  create_table 'reminders', force: :cascade do |t|
    t.bigint 'note_id', null: false
    t.datetime 'notification_time'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['note_id'], name: 'index_reminders_on_note_id'
  end

  create_table 'sharings', force: :cascade do |t|
    t.bigint 'note_id', null: false
    t.bigint 'user_id', null: false
    t.integer 'permission', default: 0
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['note_id'], name: 'index_sharings_on_note_id'
    t.index ['user_id'], name: 'index_sharings_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'items', 'notes'
  add_foreign_key 'notes', 'users'
  add_foreign_key 'reminders', 'notes'
  add_foreign_key 'sharings', 'notes'
  add_foreign_key 'sharings', 'users'
end
