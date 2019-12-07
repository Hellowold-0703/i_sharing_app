class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(8)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
     redirect_to notifications_path
  end
end
