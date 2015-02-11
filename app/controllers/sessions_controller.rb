class SessionsController < ApplicationController
  def new
    render :new

  end

  def create
    user = User.find_by_credentials(params[:session][:username], params[:session][:password])
    if user
      sign_in(user)
      redirect_to cats_url
    else
      render :new
    end

  end
end
