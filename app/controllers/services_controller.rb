class ServicesController < ApplicationController
  before_action :sanitize_params

  def new
  end

  def index
    @services = Service.where(service_provider_id: params[:service_provider_id]).includes(:service_categories)
  end

  def create
    @service = Service.new(service_params)
    service_categories = ServiceCategory.where(id: params[:service_categories])
    @service.service_categories << service_categories
    @service.save
    render :new if @service.errors.any?
    redirect_to service_provider_services_path(params[:service_provider_id]), notice: 'Service successfuly created.'
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
