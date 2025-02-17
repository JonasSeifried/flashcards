class Flashcard < ApplicationRecord
  belongs_to :deck
  has_many :user_flashcard_progresses, dependent: :destroy
  has_rich_text :body
  validates :title, :body, :deck, presence: true
  broadcasts_to :deck
end
