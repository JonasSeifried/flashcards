class DecksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck, only: %i[show edit update destroy]

  def show
    authorize @deck
    @new_flashcard = Flashcard.new(deck: @deck)
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(params.expect!(deck: [ :name, :group_id ]))
    authorize @deck.group if @deck.group
    if @deck.save
      redirect_to @deck
    else
      flash[:alert] = @deck.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @deck
  end

  def update
    authorize @deck
    if @deck.update(params.expect!(deck: [ :name ]))
      redirect_to @deck
    else
      flash[:alert] = @deck.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @deck
    @deck.destroy
    redirect_to @deck.group
  end

  private
    def set_deck
      @deck = Deck.find(params[:id])
    end
end
