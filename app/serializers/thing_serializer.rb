class ThingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :content
  has_many :occurrences

  def occurrences
    object.occurrences.map { |o| o.id }
  end
end
