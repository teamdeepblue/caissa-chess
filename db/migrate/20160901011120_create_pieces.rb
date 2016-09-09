class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :piece_id 
      t.integer :player_id 
      t.string :type 
      t.integer :x_position 
      t.integer :y_position 
      
      t.timestamps null: false
    end
  end
end
