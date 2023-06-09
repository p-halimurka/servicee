class CreateServiceCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :service_categories do |t|
      t.string :name
      t.text :description
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
