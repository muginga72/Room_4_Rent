require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  describe "GET /bookings" do
    it "returns a success response" do
      get bookings_path
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get bookings_path
      expect(response).to render_template(:index)
    end

    it "assigns @bookings" do
      booking = FactoryBot.create(:booking)
      get bookings_path
      expect(assigns(:bookings)).to eq([booking])
    end
  end

  # add more request tests for other actions as needed
end