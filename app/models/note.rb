# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  title      :string
#  content    :text
#  color      :string
#  archived   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  searchkick
  # Associations
  belongs_to :user, required: true
  has_many :items
  has_many_attached :images

  # Validates
  validates :title, :content, presence: true
end
