json.extract! room, :id, :room_size, :room_class, :room_status, :room_address, :room_city, :room_state, :room_zip, :room_country, :room_price, :room_description, :room_smoke, :number_of_beds, :bed_size, :created_at, :updated_at
json.url room_url(room, format: :json)
