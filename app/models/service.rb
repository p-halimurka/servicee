class Service < ApplicationRecord
  has_and_belongs_to_many :service_categories
  has_many :bookings, as: :bookable
  has_many :reviews, as: :reviewable
  belongs_to :service_provider

  enum :pricing_type, { fixed: 0, per_hour: 1 }

  def bookings_on(date = DateTime.today)
    bookings.where('start_time >= ?', date)
            .where('start_time < ?', date + 1.day)
            .order(:start_time)
  end

  def requires_confirmation_and_has_unconfirmed_bookings?(date = nil)
    any_unconfirmed_bookings = if date
                                 bookings.where('date(start_time) = ?', date).unconfirmed.any?
                               else
                                 bookings.unconfirmed.any?
                               end
    requires_confirmation && any_unconfirmed_bookings
  end
end
