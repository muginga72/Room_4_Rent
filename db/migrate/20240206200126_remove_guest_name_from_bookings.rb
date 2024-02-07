class RemoveGuestNameFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :full_name, :string
  end
end
