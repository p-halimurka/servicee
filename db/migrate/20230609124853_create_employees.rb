class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.references :user
      t.references :employer, foreign_key: { to_table: :service_providers }

      t.timestamps
    end
  end
end
