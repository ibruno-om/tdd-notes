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
#  user_id    :bigint           not null
#
class Note < ApplicationRecord
  searchkick
  # Associations
  belongs_to :user, required: true
  has_one :reminder, inverse_of: :note
  has_many :items
  has_many :sharings
  has_and_belongs_to_many :labels
  has_many_attached :images

  # Validates
  validates :title, :content, presence: true

  def search_data
    {
      title: title,
      content: content,
      user_id: user&.id
    }
  end
end
