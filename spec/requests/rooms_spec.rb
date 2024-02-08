require 'rails_helper'

RSpec.describe "RoomsControllers", type: :request do
  describe "get rooms_path" do

  end
  describe "get room_path" do

  end
  describe "get new_room_path" do
    it "renders the :new template" do
      get room_path(:new)
      expect(response).to render_template(:new)
    end
  end
  describe "get edit_room_path" do

  end
  describe "post rooms_path with valid data" do

  end
  describe "post rooms_path with invalid data" do

  end
  describe "put room_path with valid data" do

  end
  describe "put room_path with invalid data" do

  end
  describe "delete a room record" do
  
  end
end
