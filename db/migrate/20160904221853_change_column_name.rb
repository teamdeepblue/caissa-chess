class ChangeColumnName < ActiveRecord::Migration
  def change 
  	rename_column :pieces, :user_id, :player_id
  end
end
