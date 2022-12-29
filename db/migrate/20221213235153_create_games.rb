class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games, id: :uuid do |t|
      t.string :name
      t.jsonb :cards, defaults: {}
      t.jsonb :decks, defaults: []
      t.string :winner
      t.references :previous_game, null: true, type: :uuid, foreign_key: true,
        foreign_key: { to_table: :games }
      t.timestamps
    end
  end
end
