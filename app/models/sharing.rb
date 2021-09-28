# frozen_string_literal: true

class Sharing < ApplicationRecord
  # Associations
  belongs_to :note, required: true
  belongs_to :user, required: true

  # Validates
  validates :note, :user, :permission, presence: true

  enum permission: %i[view edit]
end
