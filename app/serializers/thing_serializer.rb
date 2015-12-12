class ThingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :content
end
