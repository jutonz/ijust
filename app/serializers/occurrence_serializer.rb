class OccurrenceSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :thing_id
end

