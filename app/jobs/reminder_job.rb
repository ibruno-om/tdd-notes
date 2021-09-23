class ReminderJob < ApplicationJob
  queue_as :reminders

  discard_on ActiveRecord::RecordNotFound

  def perform(id:)
    reminder = Reminder.find(id)
    current_user = reminder.note.user
    ReminderNotificationChannel.broadcast_to("reminder_#{current_user.id}", title: reminder.note.title)
  end
end
