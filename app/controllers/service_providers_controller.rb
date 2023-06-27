class ServiceProvidersController < ApplicationController
  def dashboard
  end

  def chats
    @service_consumers = ServiceConsumer.all.includes(:user)
  end
end
