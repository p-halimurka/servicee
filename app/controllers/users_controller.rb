class UsersController < ApplicationController
  def show
  end

  def switch_sign_up_type
    
    respond_to(&:turbo_stream)
  end
end
