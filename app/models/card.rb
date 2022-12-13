class Card < ApplicationRecord
  has_many :card_types
  has_many :types, through: :card_types

  scope :colour_search, ->(value) { value.present? ? where(colour: value) : self }
  scope :collection_search, ->(value) { value.present? ? where(collection: value) : self }
  scope :state_search, ->(value) do
    case value.to_sym
    when :processed
      where(effect: [nil, '']).or(where.not("effects::text in ('{}', '[]')"))
    when :unprocessed
      where.not(effect: [nil, '']).where("effects::text in ('{}', '[]')")
    else
      self
    end
  end
  scope :name_search, ->(value) { value.present? ? where("name ILIKE ?", "%#{value}%") : self }
end
