class ServiceProvider < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :service_provider_categories
  has_many :employees, foreign_key: :employer_id
  has_many :services
  has_many :off_days

  enum :person_type, { individual: 0, company: 1 }

  def any_available_employees_at?(datetime = DateTime.now)
    false
  end

  def following_off_days
    OffDay.where(service_provider_id: id)
          .where('date >= ?', Date.today).pluck(:date)
  end

  def chat_room_with(interlocutor)
    rooms = Room.where(first_subscriber_id: user.id, second_subscriber_id: interlocutor.user.id)
    rooms += Room.where(first_subscriber_id: interlocutor.user.id, second_subscriber_id: user.id)
    rooms.first
  end

  def any_service_requires_confirmation_and_with_unconfirmed_bookings?
    services.includes(:bookings).any? do |s|
      s.requires_confirmation && s.bookings.any?(&:unconfirmed?)
    end
  end
end
