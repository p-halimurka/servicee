class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2, default: 0.0
      t.integer :duration_in_minutes
      t.boolean :whole_day
      t.boolean :active
      t.references :service_provider, index: true
      t.timestamps
    end

    create_join_table :service_categories, :services
  end
end
