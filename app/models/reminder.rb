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
class Reminder < ApplicationRecord
  belongs_to :note, required: true
  validates :note, :notification_time, presence: true

  after_create :scheduled_at

  private

  def scheduled_at
    ReminderJob.set(wait_until: notification_time).perform_later(id: id)
  end
end
