class SetUrlColumnAsIndex < ActiveRecord::Migration
  def change
    add_index :maps, :url, unique: true
  end
end
