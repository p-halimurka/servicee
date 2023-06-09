class Booking < ApplicationRecord
  belongs_to :bookable, polymorphic: true
end
