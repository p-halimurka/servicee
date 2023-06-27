class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :employer, class_name: 'ServiceProvider', foreign_key: :employer_id
  has_many :off_days
end
