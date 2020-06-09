class Room < ApplicationRecord
  # チャット
  has_many :user_rooms
  has_many :chats
  has_many :users, through: :user_rooms
end
