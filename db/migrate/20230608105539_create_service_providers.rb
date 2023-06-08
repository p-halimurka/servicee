class CreateServiceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_providers do |t|
      t.references :user, index: true
      t.references :service_provider_category, index: true
      t.string :bio
      t.string :phone_number
      t.jsonb :address
      t.timestamps
    end
  end
end
