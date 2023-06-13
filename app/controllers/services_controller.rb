class ServicesController < ApplicationController
  before_action :sanitize_params

  def new
  end

  def index
    @services = Service.where(service_provider_id: params[:service_provider_id])
                       .includes(:service_categories)
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
    @off_days = OffDay.where(service_provider_id: @service_provider.id)
                      .where('date >= ?', Date.today).pluck(:date)
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
    @off_days = OffDay.where(service_provider_id: service_provider.id)
                      .where('date >= ?', Date.today).pluck(:date)

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
