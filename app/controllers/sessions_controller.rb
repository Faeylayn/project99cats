class SessionsController < ApplicationController
  before_action :already_signed_in

  def new
    render :new

  end

  def create
#    redirect_to new_session_url if params[:session][:username].nil? || params[:session][:password].nil?
    user = User.find_by_credentials(params[:session][:username], params[:session][:password])
    if user
      sign_in(user)
      redirect_to cats_url
    else
      render :new
    end

  end


  def destroy
    user = current_user
    if user
      user.reset_session_token!
      session[:token] = nil
    end
      redirect_to cats_url

  end

end
