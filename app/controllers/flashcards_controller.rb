class FlashcardsController < ApplicationController
  allow_unauthenticated_access only: %i[]
  before_action :set_flashcard, only: %i[show edit update destroy]
  before_action :user_in_group_of_flashcard, only: %i[show edit update destroy]

  def index
    @flashcards = Flashcard.where(deck: Deck.where(group: Group.joins(:memberships).where(memberships: { user: Current.session.user })))
  end

  def show
  end

  def new
    @flashcard = Flashcard.new
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    if @flashcard.save
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
    redirect_to @flashcard.deck_path
  end

  private
    def set_flashcard
      @flashcard = Flashcard.find(params[:id])
    end
    def flashcard_params
      params.expect(flashcard: [ :title, :body ])
    end
    def user_in_group_of_flashcard
      group = @flashcard.deck.group

      unless group.users.include?(Current.session.user)
        redirect_to root_path, alert: "You are not a member of this group and cannot access this flashcard."
      end
    end
end
