class UserFlashcardProgress < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard
end
