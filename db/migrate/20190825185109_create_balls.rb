class CreateBalls < ActiveRecord::Migration[5.1]
  def change
    create_table :balls do |t|
      t.integer :frame_id
      t.integer :pins

      t.timestamps
    end
  end
end
