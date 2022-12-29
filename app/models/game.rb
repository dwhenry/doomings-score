class Game < ApplicationRecord
  belongs_to :previous_game, class_name: "Game", required: false

  has_many :players
  has_many :users, through: :players

  def users_and_data(user_ids=nil)
    self.cards ||= {}

    card_records = Card.where(id: cards.keys).index_by(&:id)
    cards_by_owner = cards.values.
      map { |card| [card_records[card["card_id"]], card] }.
      group_by { |_, card| card["owner"] }

    filtered_users = users
    filtered_users = filtered_users.where(id: user_ids) if user_ids

    filtered_users.map do |user|
      [
        user,
        score(cards_by_owner, user),
        cards_by_owner.fetch(user.id, []).
          sort_by { |card, _| card.name },
      ]
    end
  end

  def score(cards_by_owner, user)
    card_value = cards_by_owner.fetch(user.id, []).
      sum { |card, _| card.points || 0 }

    # actually calculate this based on card types
    bonus_points = 0

    card_value + bonus_points
  end
end
