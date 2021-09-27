# frozen_string_literal: true

# == Schema Information
#
# Table name: reminders
#
#  id                :bigint           not null, primary key
#  note_id           :bigint           not null
#  notification_time :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class ReminderSerializer < ActiveModel::Serializer
  attributes :id, :notification_time

  def notification_time
    object.notification_time.zone
  end
end
