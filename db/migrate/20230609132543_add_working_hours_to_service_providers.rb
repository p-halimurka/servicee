class AddWorkingHoursToServiceProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :service_providers, :first_working_hour, :time
    add_column :service_providers, :last_working_hour, :time
  end
end
