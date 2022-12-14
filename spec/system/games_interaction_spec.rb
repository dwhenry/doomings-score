require "rails_helper"

RSpec.describe "Game interactions" do
  context "when user is anonymize" do
    it "can start a new game" do
      visit root_path

      click_on "Score a new Game"

      fill_in "Please enter you name:", with: "Jim-Bob"
      click_on :continue

      expect(page).to have_content("Scoring for")
      within ".players" do
        expect(page).to have_content("Jim-Bob")
      end
    end

    it "can join an existing game" do
      existing_game = Game.create(players: ["Doug"])

      visit root_path

      fill_in "game_id", with: existing_game.code
      click_on "Add your score to a game"

      fill_in "Please enter you name:", with: "Jim-Bob"
      click_on :continue

      expect(page).to have_content("Scoring for")
      within ".players" do
        expect(page).to have_content("Doug")
        expect(page).to have_content("Jim-Bob")
      end
    end
  end

  context "when user is logged in" do
    xit "can start a new game" do

    end

    xit "can join an existing game" do

    end
  end
end
