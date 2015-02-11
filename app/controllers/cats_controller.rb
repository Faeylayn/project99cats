class CatsController < ApplicationController
  skip_before_action :already_signed_in, only: [:edit, :create, :new]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @requests = CatRentalRequest.where(:cat_id => params[:id]).order(:start_date)
    render :show

  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    user = current_user
    if user
      params[:cat][user_id] = user.id
      @cat = Cat.new(cat_params)
      @requests = []
      if @cat.save
        render :show
      else
        render :new
      end
    else
      redirect_to new_session_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    user = current_user
    if user.id == @cat.user_id
      render :edit
    else
      flash[:errors] = "can't edit a cat that isn't yours"
      redirect_to cat_url(@cat)
    end

  end


  private
  def cat_params
    params.require(:cat).permit(:color, :name, :sex, :description, :birth_date, :user_id)
  end
end
