class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#  protect_from_forgery with: :exception
  helper_method :current_user, :sign_in

  def current_user
    return nil unless session[:token]
    @cu ||= User.find_by(:session_token => session[:token])

  end

  def sign_in(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end



end
