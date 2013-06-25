class SessionsController < ActionController::Base
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!" 
  end

  def destroy
    logout
    # redirect_to root_url, :notice => "You have been logged out."
    app_id = Settings.mindvalley.accounts.key
    redirect_to "#{Settings.mindvalley.accounts.api}logout?app_id=#{app_id}"
    # redirect_to root_url, notice: "Signed out!"
  end

  private

  def logout
    session[:user_id] = nil
  end

end
