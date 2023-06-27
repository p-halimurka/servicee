class RenameFirstWorkingHour < ActiveRecord::Migration[7.0]
  def change
    rename_column :service_providers, :first_working_hour, :opening_hour
  end
end
