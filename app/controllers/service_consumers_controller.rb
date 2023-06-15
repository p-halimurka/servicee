class ServiceConsumersController < ApplicationController
  def dashboard
  end

  def chats
    @service_providers = ServiceProvider.all.includes(:user)
  end
end
