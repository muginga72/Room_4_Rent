json.extract! booking, :id, :check_in, :check_out, :full_name, :created_at, :updated_at
json.url booking_url(booking, format: :json)
