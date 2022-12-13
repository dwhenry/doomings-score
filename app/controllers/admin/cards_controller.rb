module Admin
  class CardsController < ApplicationController
    layout "admin"
    def index
      search = CardSearch.new(search_params)

      pagy, cards = pagy(search.apply(Card.includes(:types).order(:name)))
      render :index, locals: { pagy: pagy, cards: cards, search: search }
    end

    def show
      card =
        case params[:select]
        when "previous"
          prev = Card.find(params[:id])
          Card.order(name: :desc).where("name < ?", prev.name).first
        when "next"
          prev = Card.find(params[:id])
          Card.order(name: :asc).where("name > ?", prev.name).first
        else
          Card.find(params[:id])
        end

      render :show, locals: { card: card }
    end

    def update
      card = Card.find(params[:id])
      card.update(update_params)

      redirect_to admin_card_path(card)
    end

    private

    def search_params
      params.fetch(:card_search, {}).permit(:colour, :collection, :state, :name)
    end

    def update_params
      params.require(:card).permit(
        effects: [
          :has_effect, # attributes
          :type,
          :effect_count, # effect_count
          :trait_colour, :trait_count, #trait_count
        ]
      )
    end
  end
end
