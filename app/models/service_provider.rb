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
end
