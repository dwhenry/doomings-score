# we store the card data here so that it can be shared between spec without having
# the overhead of reading it from file for each spec
module CardStore
  class << self
    def card(name)
      @cards ||= {}
      @cards[name] ||=
        JSON.parse(File.read(Rails.root.join("db", "cards", "#{name}.json")))
    end
  end
end

FactoryBot.define do
  factory :card do
    name { "AGE OF PEACE" } # part of the default Classic collection

    after(:build) do |card, _evaluator|
      CardStore.card(card.name).each do |field, value|
        if field == "types"
          value.each do |type_values|
            card.types << Type.find_or_create_by(
              name: type_values["name"],
              subtype: type_values["subtype"]
            )
          end
        else
          card[field] = value
        end
      end
    end
  end
end
