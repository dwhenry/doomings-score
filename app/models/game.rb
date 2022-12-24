class Game < ApplicationRecord
  belongs_to :previous_game, class_name: "Game", required: false

  has_many :players
  has_many :users, through: :players
end
