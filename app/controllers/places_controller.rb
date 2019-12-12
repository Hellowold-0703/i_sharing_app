class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  
  def index
    @places = Place.includes(:user)
    @hash = Gmaps4rails.build_markers(@places) do |places, marker|
      marker.lat places.latitude
      marker.lng places.longitude
      marker.infowindow render_to_string( partial: "places/infowindow",
                                          locals: { place: places})
      marker.json({id: places.id})
    end
  end

  def all
    @places = Place.includes(:user).search(params[:search])
  end


  def show
    @comment = Comment.new
    @comments = @place.comments.includes(:user)
  end

  
  def new
    @place = Place.new
    4.times {@place.images.build}
  end

 
  def edit
    image_amount = 4
    image_amount.freeze
    num = image_amount - (@place.images.length)
    num.times {@place.images.build}
  end

 
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

  
  def update
      if @place.update(update_params)
        respond_to do |format|
          format.html { redirect_to @place }
          format.json { render :show, status: :ok, location: @place }
        end
      else
        flash[:alert] = '編集できません。内容を確認してください。'
        redirect_to edit_place_path
      end
  end
  
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private
   
    def set_place
      @place = Place.find(params[:id])
    end

    
    def place_params
      params.require(:place).permit(:title, :address, :description, :latitude, :longitude, images_attributes: [:image], ).merge(user_id: current_user.id)
    end

    def update_params
      params.require(:place).permit(:title, :address, :description, :latitude, :longitude, images_attributes: [:image, :id], ).merge(user_id: current_user.id)
    end
end
