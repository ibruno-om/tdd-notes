# frozen_string_literal: true

class Reminder < ApplicationRecord
  belongs_to :note, required: true
  validates :note, :notification_time, presence: true

  after_create :scheduled_at

  private

  def scheduled_at
    ReminderJob.set(wait_until: notification_time).perform_later(id: id)
  end
end
