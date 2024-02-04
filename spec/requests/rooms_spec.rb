require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /rooms" do
    it "returns a success response" do
      get rooms_path
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get rooms_path
      expect(response).to render_template(:index)
    end

    it "assigns @rooms" do
      room = FactoryBot.create(:room)
      get rooms_path
      expect(assigns(:rooms)).to eq([room])
    end
  end

  # add more request tests for other actions as needed
end
