require "rails_helper"

RSpec.describe "Game scoring" do
  let!(:card)  { create(:card) }
  let!(:card2)  { create(:card, name: "AUTOMIMICRY") }
  let!(:game) { create(:game_with_users) }

  it "can add and remove cards to a game" do
    visit score_path(game.name)
    user = game.users.first

    # add a card
    click_test_id("add-card-#{card.name}")
    wait_for_turbolinks
    match_cards([user, card, 1])

    # add a second card of the same type
    click_test_id("add-card-#{card.name}")
    wait_for_turbolinks
    match_cards([user, card, 2])

    # add a different card
    click_test_id("add-card-#{card2.name}")
    wait_for_turbolinks
    match_cards([user, card, 2], [user, card2, 1])

    # remove a card
    click_test_id("remove-card-#{card2.name}")
    wait_for_turbolinks
    match_cards([user, card, 2])

    # remove all instance of a specific card
    click_test_id("remove-all-#{user.id}-#{card.name}")
    wait_for_turbolinks
    match_cards([user])
  end

  it "can add cards to a specific user" do
    user = create(:user)
    game.users << user

    visit score_path(game.name)
    user2 = User.where.not(name: user.name).first

    # add a card to a user
    click_test_id("user-#{user.id}")
    click_test_id("add-card-#{card.name}")
    wait_for_turbolinks
    match_cards([user, card, 1])

    # add a card to the other user
    click_test_id("user-#{user2.id}")
    click_test_id("add-card-#{card.name}")
    wait_for_turbolinks
    match_cards([user, card, 1], [user2, card, 1])
  end

  def match_cards(*cards)
    expected_data = {}
    cards.each do |user, card, count|
      expected_data[user.id] ||= {}
      next unless card

      expected_data[user.id][card.id] = {
        "actions" => "???",
        "card_id" => card.id,
        "count" => count,
        "owner" => user.id,
      }
    end

    expect(game.reload.cards).to eq(expected_data)
  end
end
