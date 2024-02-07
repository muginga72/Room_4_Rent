require 'rails_helper'
RSpec.describe Room, type: :model do
  subject { Room.new(user_id: 1, room_size: "200", room_class: "studio", room_status: "Available", room_address: "123 Main St",
    room_city: "South Portland", room_state: "Maine", room_country: "United States", room_price: 100.0, room_description: "nice room", number_of_beds: 4, bed_size: "Twin XL"
  )}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a room_address" do
    subject.room_address=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a city" do
    subject.room_city=nil
    expect(subject).to_not be_valid
  end
end