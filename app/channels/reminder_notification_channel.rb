class ReminderNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_for "reminder_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
