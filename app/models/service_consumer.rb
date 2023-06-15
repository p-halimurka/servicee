class ServiceConsumer < ApplicationRecord
  belongs_to :user
  has_many :bookings

  def chat_room_with(service_provider)
    rooms = Room.where(first_subscriber_id: user.id, second_subscriber_id: service_provider.user.id)
    rooms += Room.where(first_subscriber_id: service_provider.user.id, second_subscriber_id: user.id)
    rooms.first
  end
end
