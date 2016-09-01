class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :piece_id 
      t.integer :user_id 
      t.string :color 
      t.integer :game_id 
      
      t.timestamps null: false
    end
  end
end
