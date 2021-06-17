# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :note

  validates :description, presence: true
end
