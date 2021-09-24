# frozen_string_literal: true

class Label < ApplicationRecord
  # Associations
  has_and_belongs_to_many :notes
  # Validates
  validates :name, presence: true
end
