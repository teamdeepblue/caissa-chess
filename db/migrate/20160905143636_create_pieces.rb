class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.integer :x_position
      t.integer :y_position
      t.string :type

      t.timestamps null: false
    end
  end
end
