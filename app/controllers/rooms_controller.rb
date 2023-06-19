class RoomsController < ApplicationController
  def create
    @room = Room.new(first_subscriber_id: current_user.id, second_subscriber_id: params[:receiver_id])
    @room.save
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.time_ordered.includes(:user)
  end

  def send_message
    @room = Room.find(params[:id])
    receiver_id = if @room.first_subscriber_id == current_user.id
                    @room.second_subscriber_id
                  elsif @room.second_subscriber_id == current_user.id
                    @room.first_subscriber_id
                  end
    room_name = "room-#{@room.first_subscriber_id}-#{@room.second_subscriber_id}"
    @message = Message.new(body: params[:body], user_id: params[:user_id], room_id: params[:id])
    @message.save
    ActionCable.server.broadcast(
      "chat_#{room_name}",
      {
        sent_by: current_user.full_name,
        body: params[:body],
        receiver_id: receiver_id,
        sender_id: current_user.id,
        message_id: @message.id
      }
    )
    ActionCable.server.broadcast(
      'message_notifications',
      {
        sent_by: current_user.full_name,
        receiver_id: receiver_id
      }
    )
  end
end
