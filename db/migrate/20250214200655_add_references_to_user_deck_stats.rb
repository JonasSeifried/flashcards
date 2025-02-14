class AddReferencesToUserDeckStats < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_deck_stats, :user, null: false, foreign_key: true
    add_reference :user_deck_stats, :deck, null: false, foreign_key: true
  end
end
