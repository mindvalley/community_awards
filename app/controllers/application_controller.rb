class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  before_filter :instantiate_controller_and_action_names,
    :set_current_user,
    :authenticate_user!

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  helper_method :current_user, :user_signed_in?

  layout :layout_by_resource
  
  def layout_by_resource
    if user_signed_in?
      "application"
    else
      "application_unauthorized"
    end
  end

  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end

  private

  def authenticate_user!
    # TODO: make this better
    redirect_to '/auth/mindvalley' unless current_user
  end

  # see http://stackoverflow.com/questions/3742785/rails-3-devise-current-user-is-not-accessible-in-a-model
  def set_current_user
    User.current_user = current_user
  end
  
end
