class CatRentalRequestsController < ApplicationController

  def index
    @requests = CatRentalRequest.all
    render :index
  end

  def new
    @cats = Cat.all
    @request = CatRentalRequest.new
    render :new

  end

  def create
    params[:request][:status] = "pending"
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_url(params[:request][:cat_id])
    else
      @cats = Cat.all
      render :new
    end


  end

  def deny
    @request = CatRentalRequest.find(params[:cat_rental_request_id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  def approve
    @request = CatRentalRequest.find(params[:cat_rental_request_id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  private

  def own_cat
    request = CatRentalRequest.find(params[:id])
    user = current_user
    if user.id != request.cat.user_id
      flash[:errors] = "can't edit a cat that isn't yours"
      redirect_to cat_url(request.cat)
    end

  end

  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
