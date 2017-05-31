class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
  belongs_to :chat
  belongs_to :user
end
