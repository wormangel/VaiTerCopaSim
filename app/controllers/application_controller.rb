class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected
  def require_authorization
  	redirect_to :root unless current_user
  end
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def profile_pic(size = 'square')
  	@profile_pic = 'http://graph.facebook.com/'+ current_user.uid + "/picture?type=" + size
  end
  
  helper_method :current_user
  helper_method :profile_pic
end
