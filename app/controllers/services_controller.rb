class ServicesController < ApplicationController
  before_action :sanitize_params

  def new
  end

  def index
    @service_provider_id = params[:service_provider_id]
    @services = Service.where(service_provider_id: @service_provider_id)
                       .includes(:service_categories)
  end

  def search
    @services = Service.all
  end

  def make_search
    service_categories_ids = if params[:service_categories].is_a?(String)
                               params[:service_categories].split(',').reject(&:blank?)
                             else
                               params[:service_categories].reject(&:blank?)
                             end
    @services = Services::FilterByCategories.new(service_categories_ids).call
    respond_to do |format|
      format.json { render json: @services }
      format.turbo_stream
    end
  end

  def show
    @service = Service.find(params[:id])
    @service_provider = @service.service_provider
    @off_days = @service_provider.following_off_days
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
    @result = Services::AvailableSlots.new(params).call
    @service = @result[:service]
    @service_provider = @result[:service_provider]
    @available_slots = @result[:available_slots]
    @duration = @result[:duration]

    respond_to(&:turbo_stream)
  end

  def update_calendar
    @service = Service.find(params[:id])
    @month = params[:month].to_i
    service_provider = @service.service_provider
    @off_days = service_provider.following_off_days

    respond_to(&:turbo_stream)
  end

  def bookings
    @service = Service.find(params[:id])
    service_provider = @service.service_provider
    @service_provider_id = service_provider.id
    @off_days = service_provider.following_off_days
  end

  def open_bookings
    @service = Service.find(params[:id])
    date = params[:date].to_date
    @bookings = @service.bookings_on(date).includes(service_consumer: :user)

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
