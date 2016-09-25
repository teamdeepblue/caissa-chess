class RemoveIdColumns < ActiveRecord::Migration
  def change
    remove_column :pieces, :piece_id
    remove_column :players, :player_id
    remove_column :games, :game_id
  end
end
