module Services
  class FilterByCategories
    def initialize(service_categories_ids)
      @service_categories_ids = service_categories_ids
    end

    def call
      filter
    end

    private

    def filter
      if @service_categories_ids.any?
        Service.joins(:service_categories)
               .where('service_categories.id IN (?)', @service_categories_ids)
      else
        Service.all
      end
    end
  end
end
