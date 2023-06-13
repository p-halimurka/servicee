class OffDaysController < ApplicationController
  def new
  end

  def create
    if current_user.service_provider?
      day_off = OffDay.new(params.slice(:date, :service_provider_id).permit!)
      day_off.save
    end
    redirect_to dashboard_service_provider_path(params[:service_provider_id]), notice: 'Day off added.'
  end
end
