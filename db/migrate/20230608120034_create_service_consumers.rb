class CreateServiceConsumers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role, :integer, default: 0, null: false
    create_table :service_consumers do |t|
      t.references :user, index: true
      t.string :phone_number
      t.jsonb :address
      t.timestamps
    end
  end
end
