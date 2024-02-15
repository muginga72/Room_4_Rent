class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    # Initialize a new booking with the selected room and date
    @booking = Booking.new(room_id: params[:room_id], check_in: params[:check_in], check_out: params[:check_out])
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings/new
  def new_booking
    @room = Room.find(params[:room].to_i)
    @booking = Booking.new(room_id: @room.id)
    render :new
  end

  # POST /bookings or /bookings.json
  def create
    # Create a new booking with the submitted parameters
    @booking = Booking.new(booking_params)

    # Assign the current user as the guest
    @booking.user_id = current_user.id
    
    # Save the booking and redirect to the confirmation page
    if @booking.save
      redirect_to booking_path(@booking), notice: "Your booking was successfully created."
    else
      # Render the new booking form with validation errors
      render :new
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    # Find the booking by its id and destroy it
    @booking = Booking.find(params[:id])
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully cancelled." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      if params[:id].present? && params[:id].to_i > 0
        @booking = Booking.find(params[:id])
      else
        redirect_to rooms_path, alert: "Invalid booking ID"
      end
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit( 
        :room_id, 
        :check_in, 
        :check_out
      )
    end

    # the method is in the booking model
    def overlapping_bookings?
      Booking.exists?(room_id: @room.room_id).where.not(id: params[:id]).where(
        '(? <= check_out) AND (check_in <= ?)', 
        booking_params[:check_in], booking_params[:check_out]
      )
    end
end
