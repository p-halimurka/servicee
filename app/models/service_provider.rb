class ServiceProvider < ApplicationRecord
  belongs_to :user
  belongs_to :service_provider_category
end
