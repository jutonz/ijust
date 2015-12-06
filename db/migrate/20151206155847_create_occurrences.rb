class CreateOccurrences < ActiveRecord::Migration
  def change
    create_table :occurrences do |t|

      t.timestamps null: false
    end
  end
end
