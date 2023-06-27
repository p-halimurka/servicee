class CreateOffDays < ActiveRecord::Migration[7.0]
  def change
    create_table :off_days do |t|
      t.references :service_provider
      t.references :employee
      t.date :date
      t.timestamps
    end
  end
end
