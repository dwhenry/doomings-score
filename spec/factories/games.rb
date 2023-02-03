FactoryBot.define do
  factory :game_with_users, class: "Game" do
    name { User.generate_name }
    decks { ["Classic"] }

    factory :game do
      transient do
        user_count { 1 }
      end

      after(:build) do |game, evaluator|
        evaluator.user_count.times do
          game.users << build(:user)
        end
      end
    end
  end
end
