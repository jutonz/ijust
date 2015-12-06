class ChangeIndexOnOccurrences < ActiveRecord::Migration
  def change
    # Remove unique constraint
    remove_index :occurrences, :thing_id
    add_index :occurrences, :thing_id
  end
end
