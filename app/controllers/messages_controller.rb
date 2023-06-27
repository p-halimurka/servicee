class MessagesController < ApplicationController
  include MessagesHelper

  def update
    @message = Message.find(params[:id])
    @message.read = params[:read]
    @message.save

    respond_to do |format|
      format.json { render json: @message }
    end
  end

  def update_collection
    @messages = Message.where(id: params[:ids])
    @messages.each do |m|
      m.read ||= true
      m.save if m.changed?
    end

    respond_to do |format|
      format.json { render json: @messages }
    end
  end
end
