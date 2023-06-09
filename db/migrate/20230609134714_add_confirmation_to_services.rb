class AddConfirmationToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :requires_confirmation, :boolean, default: false
  end
end
