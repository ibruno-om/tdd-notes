# frozen_string_literal: true

class Reminder < ApplicationRecord
  belongs_to :note, required: true
  validates :note, :notification_time, presence: true
end
