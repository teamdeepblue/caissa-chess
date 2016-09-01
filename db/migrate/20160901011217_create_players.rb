class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :player_id 
      t.integer :user_id 
      t.string :color 
      t.integer :game_id 
      
      t.timestamps null: false
    end
  end
end
