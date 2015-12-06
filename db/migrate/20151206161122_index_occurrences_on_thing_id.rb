class IndexOccurrencesOnThingId < ActiveRecord::Migration
  def change
    add_column :occurrences, :thing_id, :integer
    add_index :occurrences, :thing_id, unique: true
  end
end
