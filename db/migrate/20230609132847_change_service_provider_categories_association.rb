class ChangeServiceProviderCategoriesAssociation < ActiveRecord::Migration[7.0]
  def change
    remove_reference :service_providers, :service_provider_category, index: true
    create_join_table :service_providers, :service_provider_categories
  end
end
