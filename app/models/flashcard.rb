class Flashcard < ApplicationRecord
  belongs_to :deck
  has_many :user_flashcard_progresses, dependent: :destroy
  has_rich_text :body
  validates :title, presence: true
  validates :body, presence: true
end
