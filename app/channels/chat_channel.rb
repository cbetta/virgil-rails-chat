# TODO: (11) Require the Virgil SDK

class ChatChannel < ApplicationCable::Channel
  # TODO: (12) Include the Virgil SDK Highlevel methods

  # subscribe to new incoming messages
  # between these 2 parties
  def subscribed
    stream_for chat
  end

  # listen to new speak events,
  # storing the message and publishing
  # it to the channel
  def speak data
    Message.create! chat_id: chat.id,
                    content: data['message'],
                    user_id: current_user.id
  end

  # TODO: (14) Implement a server side method to publish a card

  private

  # load the channel to ensure it
  # belongs to this user
  def chat
    current_user.chats.find(params[:id])
  end

  # TODO: (13) Initialize the Virgil SDK
end
