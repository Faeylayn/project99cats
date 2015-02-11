class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :sign_in, :already_signed_in

  def current_user
    return nil unless session[:token]
    @current_session ||= Session.find_by(:session_token => session[:token])
    @cu ||= User.find(@current_session.user_id)

  end

  def sign_in(user)
    new_session = Session.new
    new_session.user_id = user.id
    new_session.current_env = request.env["HTTP_USER_AGENT"]
    if new_session.save
      session[:token] = new_session.session_token
    end
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
