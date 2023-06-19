module MessagesHelper
  def unread_message_class(message)
    "message-#{message.id} message-to-be-updated" if message.user != current_user && message.unread?
  end
end
