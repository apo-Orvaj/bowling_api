class AddScoreToFrames < ActiveRecord::Migration[5.1]
  def change
    add_column :frames, :score, :decimal
  end
end
