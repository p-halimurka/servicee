class ServiceProvider < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :service_provider_categories
  has_many :employees, foreign_key: :employer_id

  enum :person_type, { individual: 0, company: 1 }
end
