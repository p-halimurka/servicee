class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  scope :unread, -> { where(read: false) }
  scope :time_ordered, -> { order(:created_at) }

  def unread?
    read == false
  end
end
