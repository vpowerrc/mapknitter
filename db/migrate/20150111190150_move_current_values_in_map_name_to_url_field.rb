class MoveCurrentValuesInMapNameToUrlField < ActiveRecord::Migration
  def up
  	execute "UPDATE maps m SET m.url = m.name"
  end

  def down
  	execute "UPDATE maps m SET m.url = ''"
  end
end
