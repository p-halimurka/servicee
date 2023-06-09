class AddPriceTypeToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :pricing_type, :integer, default: 0
  end
end
