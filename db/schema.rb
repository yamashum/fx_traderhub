# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_231_019_131_248) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.integer 'record_id', null: false
    t.integer 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'bulletin_chats', force: :cascade do |t|
    t.text 'content'
    t.integer 'user_id'
    t.integer 'bulletin_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['bulletin_id'], name: 'index_bulletin_chats_on_bulletin_id'
    t.index ['user_id'], name: 'index_bulletin_chats_on_user_id'
  end

  create_table 'bulletins', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'content'
    t.integer 'user_id'
    t.string 'new_attributes'
    t.string 'image'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_bulletins_on_user_id'
  end

  create_table 'chat_messages', force: :cascade do |t|
    t.text 'content'
    t.integer 'event_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_chat_messages_on_event_id'
    t.index ['user_id'], name: 'index_chat_messages_on_user_id'
  end

  create_table 'event_tags', force: :cascade do |t|
    t.integer 'event_id'
    t.integer 'tag_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_event_tags_on_event_id'
    t.index ['tag_id'], name: 'index_event_tags_on_tag_id'
  end

  create_table 'events', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'detail'
    t.string 'link', null: false
    t.datetime 'start_time'
    t.integer 'user_id'
    t.string 'tag_list'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_events_on_user_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'bulletin_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['bulletin_id'], name: 'index_likes_on_bulletin_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.text 'content'
    t.boolean 'read'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'reservations', force: :cascade do |t|
    t.integer 'event_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_reservations_on_event_id'
    t.index ['user_id'], name: 'index_reservations_on_user_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'nickname', null: false
    t.string 'email', null: false
    t.string 'icon_image'
    t.string 'self_introduction'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
