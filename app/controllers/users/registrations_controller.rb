# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user_type = params.dig(:user, :user_type)
    super
  end

  # POST /resource
  def create

    super do |resource|
      @user_id = resource.id if resource.persisted?
    end
    if params[:service_provider_category_id]
      @user_type = params.dig(:user, :user_type)
      service_provider = ServiceProvider.new(service_provider_params)
      # add the same for consumer (see params)
      service_provider.user_id = @user_id
      service_provider.save
    else
      service_consumer = ServiceConsumer.new(user_id: @user_id)
      service_consumer.save
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #  devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_type, :bio])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private

  def service_provider_params
    params.require(:user).require(:service_provider).permit(:service_provider_category_id, :phone_number, :bio)
  end

  def service_consumer_params
    params.require(:user).require(:service_consumer).permit(:phone_number)
  end
end
