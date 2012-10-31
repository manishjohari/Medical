class DevicesController < ApplicationController
  # GET /devices
  # GET /devices.xml
  def index
    @devices = Device.all
    render :layout=>false
  end

  # GET /devices/1
  # GET /devices/1.xml
  def show
    @device = Device.find(params[:id])
    render :layout=>false
  end

  # GET /devices/new
  # GET /devices/new.xml
  def new
    @device = Device.new
    render :layout=>false
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
    render :layout=>false
  end

  # POST /devices
  # POST /devices.xml
  def create
    @device = Device.create(params[:device])
    flash[:notice] = 'Device was successfully created.'
    redirect_to "/index"
  end

  # PUT /devices/1
  # PUT /devices/1.xml
  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(params[:device])
     flash[:notice] = 'Device was successfully updated.'
     redirect_to "/index"
     end
  end

  # DELETE /devices/1
  # DELETE /devices/1.xml
  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    flash[:notice] = 'Device was successfully deleted.'
    redirect_to "/index"

  end
end
