class MessagesController < ApplicationController
  def update
    @message = Message.find(params[:id])
    @message.read = params[:read]
    @message.save

    respond_to do |format|
      format.json { render json: @message }
    end
  end
end
