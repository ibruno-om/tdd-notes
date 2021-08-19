class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :color, :archived
end
