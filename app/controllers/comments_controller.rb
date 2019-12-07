class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
      redirect_to place_path(params[:place_id])
      @place = Place.find(params[:place_id])
      @place.create_notification_comment(current_user, @comment.id)
  end

  private
  
  def comment_params
    params.permit(:comment).merge(place_id: params[:place_id], user_id: current_user.id)
  end
end
