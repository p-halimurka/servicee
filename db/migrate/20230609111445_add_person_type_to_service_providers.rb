class AddPersonTypeToServiceProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :service_providers, :person_type, :integer, default: 0, null: false
  end
end
