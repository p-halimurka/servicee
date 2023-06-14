class RoomsController < ApplicationController
  def create
    @room = Room.new(first_subscriber_id: current_user.id, second_subscriber_id: params[:receiver_id])
    @room.save
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.includes(:user)
  end

  def send_message
    @room = Room.find(params[:id])
    room_name = "room-#{@room.first_subscriber_id}-#{@room.second_subscriber_id}"
    @message = Message.new(body: params[:body], user_id: params[:user_id], room_id: params[:id])
    @message.save
    ActionCable.server.broadcast(
      "chat_#{room_name}",
      {
        sent_by: current_user.full_name,
        body: params[:body]
      }
    )
  end
end
