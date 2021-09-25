# frozen_string_literal: true

class ReminderSerializer < ActiveModel::Serializer
  attributes :id, :notification_time

  def notification_time
    object.notification_time.zone
  end
end
