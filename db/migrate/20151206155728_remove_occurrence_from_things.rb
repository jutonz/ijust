class RemoveOccurrenceFromThings < ActiveRecord::Migration
  def change
    remove_column :things, :occurrence
  end
end
