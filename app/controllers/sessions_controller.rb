
class SessionsController < ApplicationController
  before_action :already_signed_in, only: [:new, :create]

  def index
    user = current_user
    

    if user
      @sessions = user.sessions
      render :index
    else
      redirect_to cats_url
    end


  end

  def new


    @user = User.new
    render :new

  end

  def create
    @user = User.find_by_credentials(params[:session][:username], params[:session][:password])
    if @user
      sign_in(@user)

      redirect_to cats_url
    else
      render :new
    end

  end


  def destroy
    user = current_user

    if user
      current_session ||= Session.find_by(:session_token => session[:token])
      current_session.destroy!
      session[:token] = nil
    end
      redirect_to cats_url

  end

end
