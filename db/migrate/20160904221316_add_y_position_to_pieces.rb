class AddYPositionToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :y_position, :integer
  end
end
