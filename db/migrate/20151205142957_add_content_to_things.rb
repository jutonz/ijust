class AddContentToThings < ActiveRecord::Migration
  def change
    add_column :things, :content, :string
  end
end
