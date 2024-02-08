require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject { Booking.new( 
    room_address:"gears", 
    guest_name: "gears", 
    check_in: date, 
    check_out: date, 
    room: FactoryBot.create(:room)
  )}
end
