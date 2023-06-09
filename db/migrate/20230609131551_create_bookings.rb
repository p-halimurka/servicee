class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :bookable, polymorphic: true, null: false
      t.references :service_provider
      t.references :employee
      t.references :service_consumer
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status

      t.timestamps
    end
  end
end
