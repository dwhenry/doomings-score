class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games, id: :uuid do |t|
      t.jsonb :players
      t.jsonb :cards
      t.datetime :last_scored
      t.string :winner
      t.references :previous_game, null: true, type: :uuid, foreign_key: true,
        foreign_key: { to_table: :games }
      t.timestamps
    end
  end
end
