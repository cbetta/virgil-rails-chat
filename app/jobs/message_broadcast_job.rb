class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ChatChannel.broadcast_to message.chat,
        message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render message
  end
end
