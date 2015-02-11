class CatsController < ApplicationController
  before_action :already_signed_in, only: [:create, :new]
  before_action :own_cat, only: [:edit]
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

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end

  end


  private
  def own_cat
    cat = Cat.find(params[:id])
    user = current_user
    if user.id != cat.user_id
      flash[:errors] = "can't edit a cat that isn't yours"
      redirect_to cat_url(cat)
    end

  end

  def cat_params
    params.require(:cat).permit(:color, :name, :sex, :description, :birth_date, :user_id)
  end
end
