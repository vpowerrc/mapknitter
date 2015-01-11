class AddUrlToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :url, :string
  end
end
