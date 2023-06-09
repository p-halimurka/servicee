class ServiceProviderCategory < ApplicationRecord
  has_and_belongs_to_many :service_providers
end
