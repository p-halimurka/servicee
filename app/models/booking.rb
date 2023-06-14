class Booking < ApplicationRecord
  belongs_to :bookable, polymorphic: true
  belongs_to :service_consumer
end
