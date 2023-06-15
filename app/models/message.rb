class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  scope :unread, -> { where(read: false) }
end
