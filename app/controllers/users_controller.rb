class UsersController < ApplicationController
  before_action :prevent_username_change!

  def show
  end

  def update
    current_user.username = params[:user][:username]
    if current_user.save
      redirect_to :root
    else
      render :show
    end
  end

  private

  def prevent_username_change!
    redirect_to :root unless current_user.username.blank?
  end
end
