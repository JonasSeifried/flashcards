class Deck < ApplicationRecord
  belongs_to :group
  has_many :flashcards, dependent: :destroy
  has_many :user_deck_stats, dependent: :destroy
end
