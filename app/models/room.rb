class Room < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :room_address, :capacity, presence: true
end
