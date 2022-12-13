class CardSearch
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :colour
  attribute :collection
  attribute :name
  attribute :state

  def initialize(args)
    args[:state] ||= "all"
    super(args)
  end

  def colours
    Card.distinct.pluck(:colour).sort
  end

  def collections
    Card.distinct.pluck(:collection).sort
  end

  def states
    %i[all processed unprocessed]
  end

  def apply(scope)
    scope.
      colour_search(colour).
      collection_search(collection).
      state_search(state).
      name_search(name)
  end
end
