class ScoresController < ApplicationController
  def index

  end

  def new
    game = Game.create(name: User.generate_name, decks: ["Classic"])
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

    game.cards ||= {}
    oldCard = game.cards[card.id]
    if oldCard.nil? || oldCard["owner"] != user.id
      newCard = game.cards[card.id] = {
        card_id: card.id,
        owner: user.id,
        actions: "???"
      }
      game.save!

      render :update, locals: { game: game, oldCard: oldCard, newCard: newCard }
    else
      render :update, locals: { game: game, oldCard: nil, newCard: nil }
    end
  end

  def destroy
    game = Game.find_by!(name: params[:id])
    card = Card.find(params[:card])

    oldCard = game.cards[card.id]
    if oldCard
      game.cards.delete(card.id)
      game.save!

      render :update, locals: { game: game, oldCard: nil, newCard: oldCard }
    else
      render :update, locals: { game: game, oldCard: nil, newCard: nil }
    end
  end
end
