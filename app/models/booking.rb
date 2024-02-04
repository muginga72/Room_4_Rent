class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # define the rooms method for the Booking object
  def status
    room.room_status
  end

  def city
    room.room_city
  end

  def rooms
    room.room_address
  end

  def guest_picture

  end
end
