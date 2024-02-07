require 'rails_helper'

RSpec.describe "RoomsControllers", type: :request do
  describe "get rooms_path" do
    it "renders the index view" do
      FactoryBot.create_list(:room, 10)
      get rooms_path
      expect(response).to render_template(:index)
    end
  end
  describe "get room_path" do
    it "renders the :show template" do
      room = FactoryBot.create(:room)
      get room_path(id: room.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the room id is invalid" do
      get room_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to rooms_path
    end
  end
  describe "get new_room_path" do
    it "renders the :new template" do
      get room_path(:new)
      expect(response).to render_template(:new)
    end
  end
  describe "get edit_room_path" do
    it "renders the :edit template" do
      room = FactoryBot.create(:room)
      get edit_room_path(room.id)
      expect(response).to render_template(:edit)
    end
  end
  describe "post rooms_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      room_attributes = FactoryBot.attributes_for(:room)
      expect { post rooms_path, params: {room: room_attributes}
    }.to change(room, :count)
      expect(response).to redirect_to room_path(id: room.last.id)
    end
  end
  describe "post rooms_path with invalid data" do
    it "does not save a new entry or redirect" do
      room_attributes = FactoryBot.attributes_for(:room)
      room_attributes.delete(:full_name)
      expect { post rooms_path, params: {room: room_attributes}
    }.to_not change(room, :count)
      expect(response).to render_template(:new)
    end
  end
  describe "put room_path with valid data" do
    it "updates an entry and redirects to the show path for the room" do
      # generate a hash of valid attributes for a room object.
      room_attributes = FactoryBot.attributes_for(:room)
      # create and save a room object in the database.
      room = FactoryBot.create(:room)
      # send a PUT request to the room_path with the room's id and the new attributes as parameters.
      put room_path(room.id), params: {room: room_attributes}
      room.reload # will reflect the changes made by the PUT request on database
      # check that the room's last name attribute is updated to match the new value in the parameters hash.
      expect(room.room_address).to eq(room_attributes[:room_address])
      # check that the response is redirect to the room's show page.
      expect(response).to redirect_to(room_path(room))
    end 
  end
  describe "put room_path with invalid data" do
    it "does not update the room record or redirect" do
      # generate a hash of valid attributes for a room object.
      room_attributes = FactoryBot.attributes_for(:room)
      # create and save a room object in the database
      room = FactoryBot.create(:room)
      # checking if the room.reload.attributes value has changed after the put room_path action
      expect { put room_path(room), params: {room: room_attributes}
      }.to change { room.reload.attributes }
      # using the be_redirect matcher, which checks if the response is redirect
      expect(response).to be_redirect
    end
  end
  describe "delete a room record" do
    it "deletes a room record" do
      # generate a hash of valid attributes for a room object.
      room_attributes = FactoryBot.attributes_for(:room)
      # create and save a room object in the database
      room = FactoryBot.create(:room)
      # remove the :room key from the attributes hash, since it is not needed for the delete action
      room_attributes.delete(:room) 
      expect {
        # execute the delete action with the room’s id and the attributes hash as parameters, and wrap it in a block.
        delete room_path(room.id), params: {room: room_attributes}
      }.to change(room, :count).by(-1) # check the delete action reduces the rooms in the database by one
    end
  end
end
