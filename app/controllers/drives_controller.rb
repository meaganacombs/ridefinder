class DrivesController < ApplicationController
  # This controller deals with drives, adding a user to a drive, creating and updating a drive (creator only)
  # and users can filter drives based on a city
  
  before_action :set_drive, only: [:show, :edit, :update, :destroy]

  # GET /drives
  # GET /drives.json
  def index
    @drives = Drive.all
    @user =  current_user
    @id = "," + @user.id.to_s + ","
  end

  # GET /drives/1
  # GET /drives/1.json
  def show
    @user =  current_user
  end

  # GET /drives/new
  def new
    @user =  current_user
    @drive = Drive.new
  end

  # GET /drives/1/edit
  def edit
    @user = current_user
  end
  
  # get '/drives/city/:city' => 'drives#filter', filters each drive and renders city.html based off which city was selected
  def filter
    @drives = Drive.all
    @user =  current_user
    if(params[:city]=="StLouis")
      @city = "St. Louis"
      else
    @city = params[:city]
    end
  end
  

  # POST /drives
  # POST /drives.json
  def create
    @drive = Drive.new(drive_params)
    @user = current_user
    respond_to do |format|
      if @drive.save
        format.html { redirect_to '/drives', notice: 'Drive was successfully created.' }
        format.json { render :show, status: :created, location: @drive }
      else
        format.html { render :new }
        format.json { render json: @drive.errors, status: :unprocessable_entity }
      end
    end
  end


  
  # PATCH/PUT /drives/1
  # PATCH/PUT /drives/1.json
  def update
    respond_to do |format|
      if @drive.update(drive_params)
        format.html { redirect_to '/drives', notice: 'Drive was successfully updated.' }
        format.json { render :show, status: :ok, location: @drive }
      else
        format.html { render :edit }
        format.json { render json: @drive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drives/1
  # DELETE /drives/1.json
  def destroy
    @drive.destroy
    respond_to do |format|
      format.html { redirect_to drives_url, notice: 'Drive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  #Adds a passenger to a drive, and adds that user's id to a list of ids,  put 'drives/:id/addPassenger' => 'drives#add_passenger'
  def add_passenger
    render nothing: true
    @drive = Drive.find(params[:id])
    passenger_id = params[:passenger_id]
    passenger_ids =  @drive.passenger_ids  + passenger_id.to_s + ","
    if(@drive.num_passengers>0)
      @drive.num_passengers -= 1
      @drive.update_attribute(:passenger_ids, passenger_ids)
      @drive.save
    end
   end
  
  # Removes a passenger from a drive, finds id and removes that from list of ids,  put 'drives/:id/removePassenger' => 'drives#remove_passenger'
  def remove_passenger
    render nothing: true
    @drive = Drive.find(params[:id])
    @drive.num_passengers +=1 
    passenger_id = params[:passenger_id]
    id_to_delete = "#{passenger_id}"
    @drive.passenger_ids = @drive.passenger_ids.delete(id_to_delete)
    if @drive.save
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drive
      @drive = Drive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drive_params
      params.require(:drive).permit(:city, :num_passengers, :driver_id, :departure_time, :departure_location, :comment)
    end
end
