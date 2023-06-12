class Service < ApplicationRecord
  has_and_belongs_to_many :service_categories
  has_many :bookings, as: :bookable
  has_many :reviews, as: :reviewable
  belongs_to :service_provider

  enum :pricing_type, { fixed: 0, per_hour: 1 }
end
