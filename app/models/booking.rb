class Booking < ApplicationRecord
  belongs_to :bookable, polymorphic: true
  belongs_to :service_consumer

  enum :status, { unconfirmed: 0, confirmed: 1, completed: 2, declined: 3 }
  enum :update_seen, { not_seen: 0, seen: 1 }

  scope :unconfirmed, -> { where(status: :unconfirmed) }
  scope :without_declined, -> { where.not(status: :declined) }
  scope :not_seen, -> { where(update_seen: :not_seen) }
end
