class Card < ApplicationRecord
  has_many :card_types
  has_many :types, through: :card_types
end
