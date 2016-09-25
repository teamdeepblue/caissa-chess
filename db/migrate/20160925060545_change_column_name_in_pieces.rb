class ChangeColumnNameInPieces < ActiveRecord::Migration
  def change
  	rename_column :pieces, :type, :piece_name
  end
end
