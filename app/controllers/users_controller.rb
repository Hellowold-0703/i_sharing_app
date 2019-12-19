class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def likes
    @likes = current_user.likes.page(params[:page]).per(8)
    @places = current_user.places.page(params[:page]).per(8)
  end
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
