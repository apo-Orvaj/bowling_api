class AddTotalScoreToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :total_score, :decimal
  end
end
