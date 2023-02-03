require "rails_helper"

RSpec.describe "Game interactions", type: :system do
  context "when user is anonymize" do
    it "can start a new game" do
      visit root_path

      click_on "Score a new Game"

      wait_for_turbolinks

      within '[data-test-id="players"]' do
        expect(page).to have_content(User.last.name)
      end
    end

    it "can join an existing game" do
      user = User.create(name: "Doug")
      existing_game = Game.create(name: User.generate_name, users: [user])

      visit root_path

      fill_in "game_name", with: existing_game.name
      click_on "Add your score to a game"

      wait_for_turbolinks

      within '[data-test-id="players"]' do
        expect(page).to have_content("Doug")
        expect(page).to have_content(User.last.name)
      end
    end
  end
end
