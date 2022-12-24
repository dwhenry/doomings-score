class ScoresController < ApplicationController
  def index

  end

  def new
    game = Game.create(name: User.generate_name, decks: ["Classic"])
    game.users << current_user

    redirect_to score_path(game.name)
  end

  def show
    game = Game.find_by(name: params[:id])
    cards = Card.where(collection: game.decks).order(:colour, :name)

    render :show, locals: { game: game, cards: cards }
  end
end
