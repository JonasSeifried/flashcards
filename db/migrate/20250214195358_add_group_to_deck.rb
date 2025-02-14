class AddGroupToDeck < ActiveRecord::Migration[8.0]
  def change
    add_reference :decks, :group, null: false, foreign_key: true
  end
end
