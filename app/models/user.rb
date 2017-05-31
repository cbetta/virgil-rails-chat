class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true

  scope :with_username, -> { where.not(username: nil) }
  scope :except_for, -> (user){ where.not(id: user.id ) }

  def chats
    Chat.where(user1_id: id).or(Chat.where(user2_id: id))
  end
end
