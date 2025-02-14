class AddReferencesToUserFlashcardProgress < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_flashcard_progresses, :user, null: false, foreign_key: true
    add_reference :user_flashcard_progresses, :flashcard, null: false, foreign_key: true
  end
end
