class Api::PlacesController < ApplicationController
  protect_from_forgery
  
  def image_destroy
    image = Image.find(params[:img_id])
    image.destroy
  end
end