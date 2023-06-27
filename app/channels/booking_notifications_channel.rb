class BookingNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'booking_notifications'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
