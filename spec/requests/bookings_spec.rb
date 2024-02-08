require 'rails_helper'

RSpec.describe "BookingsControllers", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room, user: user) }
  let(:booking) { FactoryBot.create(:booking, user: user, room: room) }

  describe "POST /bookings" do
    context "with valid parameters" do
      let(:valid_attributes) do
        {
          check_in: Date.today + 1,
          check_out: Date.today + 2,
          user_id: user.id,
          room_id: room.id
        }
      end

      context "with invalid parameters" do
        let(:invalid_attributes) do
          {
            check_in: nil,
            check_out: nil,
            user_id: nil,
            room_id: nil
          }
        end

        it "does not create a new booking" do
          # expect {
          #   post bookings_path, params: { booking: invalid_attributes }
          # }.to_not change(Booking, :count)
        end  
      end
    end
  end

  describe "PUT /bookings/:id" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          check_in: Date.today + 3,
          check_out: Date.today + 4,
          user_id: user.id,
          room_id: room.id
        }
      end

      it "updates the requested booking" do
        # put booking_path(booking), params: { booking: new_attributes }
        # booking.reload
        # expect(booking.attributes).to include(new_attributes.stringify_keys)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        {
          check_in: nil,
          check_out: nil,
          user_id: nil,
          room_id: nil
        }
      end

      it "does not update the requested booking" do
        # implement the code here
        # original_attributes = booking.attributes
        # put booking_path(booking), params: { booking: invalid_attributes }
        # booking.reload
        # expect(booking.attributes).to include(original_attributes)
      end
    end
  end
end
