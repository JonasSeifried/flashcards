class RemoveGroupFromFlashcard < ActiveRecord::Migration[8.0]
  def change
    remove_column :flashcards, :group_id, :integer
  end
end
