require 'rails_helper'

RSpec.describe Booking, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:booking)).to be_valid
  end

  it "is invalid without a check_in date" do
    expect(FactoryBot.build(:booking, check_in: nil)).not_to be_valid
  end

  # add more validation tests for other attributes as needed

  it "belongs to a user" do
    expect(FactoryBot.build(:booking)).to belong_to(:user)
  end

  it "belongs to a room" do
    expect(FactoryBot.build(:booking)).to belong_to(:room)
  end
end
