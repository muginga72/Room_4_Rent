require 'rails_helper'

RSpec.describe Room, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:room)).to be_valid
  end

  it "is invalid without a room_size" do
    expect(FactoryBot.build(:room, room_size: nil)).not_to be_valid
  end

  # add more validations tests for other attributes as needed

  it "belongs to a user" do
    expect(FactoryBot.build(:room)).to belong_to(:user)
  end
end
