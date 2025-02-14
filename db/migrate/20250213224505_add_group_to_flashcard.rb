class AddGroupToFlashcard < ActiveRecord::Migration[8.0]
  def change
    add_reference :flashcards, :group, null: false, foreign_key: true
  end
end
