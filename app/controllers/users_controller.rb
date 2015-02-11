class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create

    user = User.new(user_params)
    user.password=(params[:user][:password])
    if user.save
      sign_in(user)
      redirect_to cats_url
    else
      render :new
    end
  end




  private
  def user_params
    params.require(:user).permit(:username)
  end

end
