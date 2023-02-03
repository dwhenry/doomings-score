class Game < ApplicationRecord
  belongs_to :previous_game, class_name: "Game", required: false

  has_many :players
  has_many :users, through: :players

  def update_card!(card:, user:, event_type: )
    self.cards ||= {}
    user_cards = cards[user.id] ||= {}
    card_data = user_cards[card.id] ||= {
      "card_id" => card.id,
      "owner" => user.id,
      "actions" => "???",
      "count" => 0
    }
    modifier = case event_type
      when "add_card" then 1
      when "remove_card" then -1
      when "remove_all" then -card_data["count"]
      end

    card_data["count"] += modifier
    cards[user.id].delete(card.id) if card_data["count"] < 1
    save!
  end

  def users_and_data(user_ids=nil)
    self.cards ||= {}

    card_ids = cards.values.flat_map(&:keys)
    card_records = Card.where(id: card_ids).index_by(&:id)

    filtered_users = users
    filtered_users = filtered_users.where(id: user_ids) if user_ids

    filtered_users.map do |user|
      [
        user,
        score(card_records, user),
        (cards[user.id] || {}).
          map { |card_id, card_data| [card_records[card_id], card_data] }.
          sort_by { |card, _| card.name },
      ]
    end
  end

  def score(cards_records, user)
    card_value = cards.fetch(user.id, []).
      sum { |card_id, _card_data| cards_records[card_id]&.points || 0 }

    # actually calculate this based on card types
    bonus_points = 0

    card_value + bonus_points
  end
end
