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
class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :color, :archived, :images

  def images
    return unless object.images.attached?

    object.images&.map do |image|
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    end
  end
end
