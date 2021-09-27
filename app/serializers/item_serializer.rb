# frozen_string_literal: true

class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description
end
