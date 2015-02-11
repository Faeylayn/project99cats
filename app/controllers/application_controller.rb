class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#  protect_from_forgery with: :exception
  helper_method :current_user, :sign_in, :already_signed_in

  def current_user
    return nil unless session[:token]
    @cu ||= User.find_by(:session_token => session[:token])

  end

  def sign_in(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def signed_in?
    !!current_user
  end

  def already_signed_in

    if signed_in?
      redirect_to cats_url
    else
    #  fail
    end
  end


end
