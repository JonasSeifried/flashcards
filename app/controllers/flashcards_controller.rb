class FlashcardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[create]
  before_action :set_deck, only: %i[create]
  before_action :set_flashcard, only: %i[show edit update destroy]


  def show
    authorize @flashcard
  end

  def create
    authorize @deck
    flashcard = Flashcard.new flashcard_params
    flashcard.deck = @deck
    if flashcard.save
      @deck.flashcards << flashcard
      return
    end
    flash[:alert] = flashcard.errors.full_messages.to_sentence
    @flashcard = flashcard
    redirect_to @deck, status: :unprocessable_entity
  end

  def edit
  end

  def update
    authorize @flashcard
    if @flashcard.update(flashcard_params)
      redirect_to @flashcard
    else
      render :edit, status: :unprocesable_entity
    end
  end

  def destroy
    @flashcard.destroy
    redirect_to @deck
  end

  private
    def set_flashcard
      @flashcard = Flashcard.find(params[:id])
      @deck = @flashcard.deck
      @group = @deck.group
    end
    def set_deck
      @deck = Deck.find(params[:deck_id])
    end
    def set_group
      @deck = Deck.find(params[:group_id])
    end
    def flashcard_params
      params.expect!(flashcard: [ :title, :body ])
    end
end
