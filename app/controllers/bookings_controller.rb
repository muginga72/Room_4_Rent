class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    if params[:user] # if the user parameter is present and true
      @bookings = Booking.by_user(current_user) # show only the bookings of the current user
    else
      @bookings = Booking.all # show all the bookings
    end
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
    @room = Room.find_by(params[:room_id])

    if @room.owner == current_user
      flash[:alert] = "You cannot book your own room."
      redirect_to rooms_path

    elsif @room.coming_soon == "Coming soon" # check if the room its coming soon and prevent the booking
      flash[:alert] = "This room is coming soon and cannot be booked yet."
      redirect_to rooms_path

    else
      @booking = Booking.new(booking_params) # create a new booking with the submitted parameters
      @booking.user_id = current_user.id # assign the current user as the guest

      if @booking.save # save the booking and redirect to the confirmation page
        @booking.room.update(booked: true) # mark the room as booked
        redirect_to booking_path(@booking), notice: "Your booking was successfully created."

      else
        flash[:error] = 'Error creating booking!'
        render :new # render the new booking form with validation errors
      end
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
        @booking = Booking.find_by(params[:id])
      else
        redirect_to rooms_path, alert: "Invalid booking ID"
      end
    end

    # def set_booking
    #   @booking = Booking.find_by_id(params[:id])
    #   redirect_to bookings_path, alert: "Invalid booking ID" 
    #     unless @booking
    #   end
    # end

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
