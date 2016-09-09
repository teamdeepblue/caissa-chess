class AddXPositionToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :x_position, :integer
  end
end
