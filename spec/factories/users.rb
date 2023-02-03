FactoryBot.define do
  factory :user do
    name { User.generate_name }
  end
end
