class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    @places = Place.includes(:user)
    @hash = Gmaps4rails.build_markers(@places) do |places, marker|
      marker.lat places.latitude
      marker.lng places.longitude
      marker.infowindow places.address 
    end
  end

  def all
    @places = Place.all
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @comment = Comment.new
    @comments = @place.comments.includes(:user)
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
    gon.place = @palce
    gon.images = @place.images

    require 'base64'
      binary_data1 = File.read(@place.images[0].file.file)
      gon.image1 = Base64.strict_encode64(binary_data1)

      if @place.images[1].present?
        binary_data2 = File.read(@place.images[1].file.file)
        gon.image2 = Base64.strict_encode64(binary_data2)
      end

      if @place.images[2].present?
        binary_data3 = File.read(@place.images[2].file.file)
        gon.image3 = Base64.strict_encode64(binary_data3)
      end
      
      if @place.images[3].present?
        binary_data4 = File.read(@place.images[3].file.file)
        gon.image4 = Base64.strict_encode64(binary_data4)
      end
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

      if @place.save
        respond_to do |format|
          format.html { redirect_to @place}
          format.json { render :show, status: :created, location: @place }
        end
      else
        flash[:alert] = '未入力の項目があります'
        redirect_to new_place_path
      end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update

      if @place.update(place_params)
        respond_to do |format|
          format.html { redirect_to @place }
          format.json { render :show, status: :ok, location: @place }
        end
      else
        flash.now[:alert] = '未入力の項目があります'
        render :edit
      end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:title, :address, :description, {images: []}, :latitude, :longitude, :images_cache).merge(user_id: current_user.id)
    end
end
