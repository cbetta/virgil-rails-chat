Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  resource :user
  resources :chat

  root to: "chat#index"
end
