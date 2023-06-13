class OffDay < ApplicationRecord
  belongs_to :service_provider, optional: true
  belongs_to :employee, optional: true
end
