class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships
  has_many :groups, through: :memberships
  has_many :user_flashcard_progresses
  has_many :user_deck_stats

  after_create :create_private_group

  def create_private_group_and_deck
    default_group = Group.create!(name: "Example Group")
    default_group.users << self
    default_group.decks.create!(name: "Example Deck")
  end


  def has_access_to_flashcard?(flashcard)
    flashcard.deck.group.users.include?(self)
  end

  def has_access_to_deck?(deck)
    deck.group.users.include?(self)
  end

  def has_access_to_group?(group)
    group.users.include?(self)
  end
end
