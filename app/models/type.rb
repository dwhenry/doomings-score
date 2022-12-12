class Type < ApplicationRecord
  has_many :card_types
  has_many :cards, through: :card_types
end
