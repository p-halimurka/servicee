class MessageNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'message_notifications'
  end
end
