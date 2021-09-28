# frozen_string_literal: true

# == Schema Information
#
# Table name: sharings
#
#  id         :bigint           not null, primary key
#  note_id    :bigint           not null
#  user_id    :bigint           not null
#  permission :integer          default("view")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Sharing < ApplicationRecord
  # Associations
  belongs_to :note, required: true
  belongs_to :user, required: true

  # Validates
  validates :note, :user, :permission, presence: true

  enum permission: %i[view edit]
end
