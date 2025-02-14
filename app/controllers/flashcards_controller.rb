class FlashcardsController < ApplicationController
  before_action :set_group
  before_action :set_flashcard, only: %i[show edit update destroy]
  allow_unauthenticated_access only: %i[ index show ]
  def index
    @flashcards = @group.flashcards
  end

  def show
  end

  def new
    @flashcard = Flashcard.new
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    if @flaschard.save
      redirect_to @flashcard
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @flashcard.update(flashcard_params)
      redirect_to @flashcard
    else
      render :edit, status: :unprocesable_entity
    end
  end

  def destroy
    @flashcard.destroy
    redirect_to flashcards_path
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
    def set_flashcard
      @flashcard = Flashcard.find(params[:id])
    end
    def flashcard_params
      params.expect(flashcard: [ :title, :body, :group_id ])
    end
end
