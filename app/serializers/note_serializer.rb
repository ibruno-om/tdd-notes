class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :color, :archived, :images

  def images
    return unless object.images.attached?

    object.images&.map do |image|
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    end
  end
end
