# frozen_string_literal: true

# == Schema Information
#
# Table name: labels
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Label < ApplicationRecord
  # Associations
  has_and_belongs_to_many :notes
  # Validates
  validates :name, presence: true
end
