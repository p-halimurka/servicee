class BookingsController < ApplicationController
  def index
    user = current_user
    if user.service_consumer?
      @bookings = Booking.where(service_consumer_id: user.service_consumer.id).includes([:bookable])
      @bookings.update_all(update_seen: :seen)
    end
  end

  def create
    booking = Booking.new(params.slice(:service_provider_id, :start_time, :status).permit!)
    service = Service.find(params[:service_id])
    booking.bookable = service
    booking.service_consumer_id = current_user.service_consumer.id
    booking.save
    if service.requires_confirmation
      ActionCable.server.broadcast(
        'booking_notifications',
        {
          service_provider_id: service.service_provider_id,
          service_id: service.id,
          booking_id: booking.id,
          date: booking.start_time.strftime('%F')
        }
      )
    end

    redirect_to bookings_path, notice: 'Successfully booked service.'
    # booking.employee = service_provider.employees.free_at(time).sample
  end

  def resolve
    @booking = Booking.find(params[:id])
    @booking.status = if params[:operation] == 'confirm'
                        :confirmed
                      elsif params[:operation] == 'decline'
                        :declined
                      end
    @booking.update_seen = :not_seen
    @booking.save
    ActionCable.server.broadcast(
      'booking_notifications',
      {
        service_consumer_id: @booking.service_consumer_id
      }
    )

    respond_to(&:turbo_stream)
  end
end
