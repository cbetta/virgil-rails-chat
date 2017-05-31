class Chat < ApplicationRecord
  belongs_to :user1, class_name: 'User', foreign_key: :user1_id
  belongs_to :user2, class_name: 'User', foreign_key: :user2_id
  has_many :messages

  def self.for user1, user2
    users = [user1, user2].sort_by(&:username)
    Chat.where(user1: users[0], user2: users[1]).first_or_create
  end
end
