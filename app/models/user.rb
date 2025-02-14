class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :user_flashcard_progresses
  has_many :user_deck_stats

  after_create :create_private_group

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def create_private_group
    default_group = Group.create!(name: "Default")
      default_group.users << self
  end
end
