module Services
  class AvailableSlots
    def initialize(params)
      @params = params
      @result = {}
    end

    def call
      find_service
      load_service_provider
      load_service_duration
      convert_supposed_date
      load_working_hours
      load_same_day_bookings_start_times
      find_available_slots
      @result
    end

    private

    def find_service
      @result[:service] = Service.find(@params[:id])
    end

    def load_service_provider
      @result[:service_provider] = @result[:service].service_provider
    end

    def load_service_duration
      @result[:duration] = @result[:service].duration_in_minutes
    end

    def convert_supposed_date
      @result[:date] = @params[:date].to_date
    end

    def load_working_hours
      date = @result[:date]
      @result[:opening_hour] = @result[:service_provider].opening_hour
                                                         .change(year: date.year, month: date.month, day: date.day)
      @result[:closing_hour] = @result[:service_provider].closing_hour
                                                         .change(year: date.year, month: date.month, day: date.day)
    end

    def load_same_day_bookings_start_times
      @result[:same_day_bookings_start_times] = @result[:service].bookings_on(@result[:date]).without_declined.pluck(:start_time)
    end

    def find_available_slots
      opening_hour = @result[:opening_hour]
      closing_hour = @result[:closing_hour]
      duration = @result[:duration]
      @result[:available_slots] = []
      while closing_hour - duration.minutes >= opening_hour
        @result[:available_slots] << opening_hour if slot_available?(opening_hour)
        opening_hour += duration.minutes
      end
    end

    def slot_available?(start_time)
      service_provider = @result[:service_provider]
      same_day_bookings_start_times = @result[:same_day_bookings_start_times]
      (service_provider.any_available_employees_at?(start_time) && service_provider.company?) ||
        same_day_bookings_start_times.exclude?(start_time)
    end
  end
end
