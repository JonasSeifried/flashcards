class Flashcard < ApplicationRecord
  belongs_to :group
  has_rich_text :body
  validates :title, presence: true
  validates :body, presence: true
end
