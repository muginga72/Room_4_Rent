class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # def available
  #   @available_room = Room.where(room_status: "available")
  # end

  # def bboked
  #   @booked_room = Room.where(room_status: "booked")
  # end

  # def pending
  #   @pending_room = Room.where(room_status: "pending")
  # end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    
    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
      # @room = Room.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(
        :user_id,
        :room_size, 
        :room_class, 
        :room_status, 
        :room_address, 
        :room_city, 
        :room_state, 
        :room_zip, 
        :room_country, 
        :room_price, 
        :room_description, 
        :room_smoke, 
        :number_of_beds, 
        :bed_size
      )
    end
end
