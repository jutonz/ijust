class AddOccurrenceToThings < ActiveRecord::Migration
  def change
    add_column :things, :occurrence, :datetime
  end
end
