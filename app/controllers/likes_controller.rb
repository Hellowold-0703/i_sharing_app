class LikesController < ApplicationController
  before_action :set_variables

  def like
    like = current_user.likes.new(place_id: @place.id)
    like.save
  end

  def unlike
    like = current_user.likes.find_by(place_id: @place.id)
    like.destroy
  end

  private

  def set_variables
    @place = Place.find(params[:place_id])
    @id_name = "#like-link-#{@place.id}"
  end
end