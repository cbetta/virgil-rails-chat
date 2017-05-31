require 'virgil/sdk'

class ChatChannel < ApplicationCable::Channel
  include Virgil::SDK::HighLevel

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

  def publishCard data
    card = virgil.cards.import(data['card'])
    virgil.cards.publish(card)
  end

  private

  # load the channel to ensure it
  # belongs to this user
  def chat
    current_user.chats.find(params[:id])
  end

  def virgil
    virgil = VirgilApi.new(context: VirgilContext.new(
        access_token: "AT.1cde554c5a649b17fd9e07157e1a7db7fac61d71218b71082635795b6356e8eb",
        credentials: VirgilAppCredentials.new(
            app_id: "f83051ab51ece376bb5268bcd32169c1b25455154ea5408e3703a442b92966d5",
            app_key_data: VirgilBuffer.from_file(Rails.root.join("app.virgilkey")),
            app_key_password: "test"))
    )
  end
end
