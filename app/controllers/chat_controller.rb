class ChatController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_has_username!

  def index
  end

  def show
    @recipient = User.find_by_username(params[:id])
    @chat = Chat.for(current_user, @recipient)
    @messages = @chat.messages
  end

  private

  def ensure_has_username!
    redirect_to :user if current_user.username.blank?
  end
end
