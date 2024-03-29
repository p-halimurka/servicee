class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :first_subscriber, foreign_key: { to_table: :users }
      t.references :second_subscriber, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
