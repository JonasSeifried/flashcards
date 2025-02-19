class FlashcardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck_and_group, only: %i[create]
  before_action :set_flashcard, only: %i[show edit update destroy]


  def show
    authorize @flashcard
  end

  def create
    puts flashcard_params
    puts @deck
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
    def set_deck_and_group
      @deck = Deck.find(params[:deck_id])
      @group = @deck.group
    end
    def flashcard_params
      params.expect!(flashcard: [ :title, :body ])
    end
end
