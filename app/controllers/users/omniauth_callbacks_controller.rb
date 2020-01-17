class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    callback_from :google
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in @user
      redirect_to root_path
      flash[:notice] = 'ログインしました'
    else
      redirect_to new_user_session_path
      flash[:alert] = 'ログインに失敗しました'
    end
  end
end