class BookingsController < ApplicationController
  def index
    user = current_user
    if user.service_consumer?
      @bookings = Booking.where(service_consumer_id: user.service_consumer.id)
    end
  end

  def create
    booking = Booking.new(params.slice(:service_provider_id, :start_time).permit!)
    service = Service.find(params[:service_id])
    booking.bookable = service
    booking.service_consumer_id = current_user.service_consumer.id
    booking.save
    redirect_to bookings_path, notice: 'Successfully booked service.'
    # booking.employee = service_provider.employees.free_at(time).sample
  end
end
