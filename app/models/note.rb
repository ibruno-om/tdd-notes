# frozen_string_literal: true

class Note < ApplicationRecord
  # Associations
  has_many_attached :images

  # Validates
  validates :title, :content, presence: true
end
