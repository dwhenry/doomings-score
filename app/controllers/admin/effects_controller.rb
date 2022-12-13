module Admin
  class EffectsController < ApplicationController
    layout false

    def show
      card = Card.find(params[:card_id])
      effect = params[:effect] || card.effects["type"] || "none"
      card.effects[:type] = effect
      render effect, locals: { card: card }
    end

    private

    def search_params
      params.fetch(:card_search, {}).permit(:colour, :collection, :state, :name)
    end
  end
end
