# frozen_string_literal: true

class SharingSerializer < ActiveModel::Serializer
  attributes :id

  # Associations
  belongs_to :note
  belongs_to :user
end
