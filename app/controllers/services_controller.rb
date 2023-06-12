class ServicesController < ApplicationController
  before_action :sanitize_params

  def new
  end

  def index
    @services = Service.where(service_provider_id: params[:service_provider_id]).includes(:service_categories)
  end

  def search
    @services = Service.all
  end

  def make_search
    params[:service_categories] = params[:service_categories].split(',') if params[:service_categories].is_a?(String)
    service_categories_ids = params[:service_categories].reject(&:blank?)
    @services = if service_categories_ids.any?
                  Service.joins(:service_categories).where('service_categories.id IN (?)', service_categories_ids)
                else
                  Service.all
                end
    respond_to do |format|
      format.json { render json: @services }
      format.turbo_stream
    end
  end

  def show
    @service = Service.find(params[:id])
    @service_provider = @service.service_provider
  end

  def create
    @service = Service.new(service_params)
    service_categories = ServiceCategory.where(id: params[:service_categories])
    @service.service_categories << service_categories
    @service.save
    render :new if @service.errors.any?
    redirect_to service_provider_services_path(params[:service_provider_id]), notice: 'Service successfuly created.'
  end

  def available_slots
    @service = Service.find(params[:id])
    @date = params[:date].to_date
    @service_provider = @service.service_provider
    @first_working_hour = @service_provider.first_working_hour.change(year: @date.year, month: @date.month, day: @date.month)
    @closing_hour = @service_provider.closing_hour.change(year: @date.year, month: @date.month, day: @date.month)
    @available_slots = []
    @available_slots << @first_working_hour
    while @first_working_hour < @closing_hour - @service.duration_in_minutes.minutes
      @first_working_hour += @service.duration_in_minutes.minutes
      @available_slots << @first_working_hour
    end
    p @available_slots
    @bookings = @service.bookings
    @duration = @service.duration_in_minutes

    respond_to(&:turbo_stream)
  end

  private

  def service_params
    params.permit(:service_categories, :title, :description, :price, :duration_in_minutes,
                  :whole_day, :requires_confirmation, :service_provider_id, :pricing_type)
  end

  def sanitize_params
    params[:pricing_type] = params[:pricing_type].to_i
  end
end
