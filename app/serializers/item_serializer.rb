# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :string
#  note_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description
end
