class AddConsumerSeenToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :update_seen, :integer, default: 0
  end
end
