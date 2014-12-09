class DrivesController < ApplicationController
  before_action :set_drive, only: [:show, :edit, :update, :destroy]

  # GET /drives
  # GET /drives.json
  def index
    @drives = Drive.all
    @user =  current_user
  end

  # GET /drives/1
  # GET /drives/1.json
  def show
  end

  # GET /drives/new
  def new
    @user =  current_user
    @drive = Drive.new
  end

  # GET /drives/1/edit
  def edit
  end
  
  def filter
    @drives = Drive.all
    @user =  current_user
    @city = params[:city]
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
        format.json { render json: @drice.errors, status: :unprocessable_entity }
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
  
  def add_passenger
    render nothing: true
    @drive = Drive.find(params[:id])
    passenger_id = params[:passenger_id]
    passenger_ids =  @drive.passenger_ids + "," + passenger_id.to_s
    if(@drive.num_passengers>0)
      @drive.num_passengers -= 1
      @drive.update_attribute(:passenger_ids, passenger_ids)
      @drive.save
      
    else
     # redirect_to '/drives', notice: 'no more room left in this drive'
      end
  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drive
      @drive = Drive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drive_params
      params.require(:drive).permit(:city, :num_passengers, :driver_id)
    end
end
