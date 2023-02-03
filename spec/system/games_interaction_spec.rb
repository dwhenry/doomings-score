require "rails_helper"

RSpec.describe "Game interactions" do
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
      existing_game = create(:game)
      user = existing_game.users.first

      visit root_path

      fill_in "game_name", with: existing_game.name
      click_on "Add your score to a game"

      wait_for_turbolinks

      new_user = User.where.not(name: user.name).first

      within '[data-test-id="players"]' do
        expect(page).to have_content(user.name)
        expect(page).to have_content(new_user.name)
      end
    end
  end
end
