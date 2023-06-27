class RenameLastWorkingHour < ActiveRecord::Migration[7.0]
  def change
    rename_column :service_providers, :last_working_hour, :closing_hour
  end
end
