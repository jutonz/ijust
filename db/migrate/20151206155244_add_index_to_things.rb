class AddIndexToThings < ActiveRecord::Migration
  def change
    add_index :things, :content, unique: true
  end
end
