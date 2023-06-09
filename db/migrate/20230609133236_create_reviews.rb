class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true, null: false
      t.string :comment
      t.integer :rating
      t.references :service_consumer
      t.timestamps
    end
  end
end
