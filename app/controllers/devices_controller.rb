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
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to(@device, :notice => 'Device was successfully created.') }
        format.xml  { render :xml => @device, :status => :created, :location => @device }
        render :layout=>false
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
        render :layout=>false
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.xml
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to(@device, :notice => 'Device was successfully updated.') }
        format.xml  { head :ok }
        render :layout=>false
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
        render :layout=>false
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.xml
  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    

    respond_to do |format|
      format.html { redirect_to(devices_url) }
      format.xml  { head :ok }
    end
  end
end
