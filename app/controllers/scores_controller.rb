class ScoresController < ApplicationController
  def index

  end

  def new
    puts params
    game_name = params.fetch(:game_name, User.generate_name)
    game = Game.find_or_create_by(name: game_name, decks: ["Classic"])
    game.users << current_user

    redirect_to score_path(game.name)
  end

  def show
    game = Game.find_by!(name: params[:id])
    game.users |= [current_user]
    cards = Card.where(collection: game.decks).order(:colour, :name)

    render :show, locals: { game: game, cards: cards }
  end

  def update
    game = Game.find_by!(name: params[:id])
    card = Card.find(params[:card])
    user = User.find(params[:user_id])

    game.update_card!(card: card, user: user, event_type: params[:event_type])

    render :update, locals: { game: game, user: user }
  end
end
