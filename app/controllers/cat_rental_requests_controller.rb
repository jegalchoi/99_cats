class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    cat_id = params[:cat_id]
    @cats_list = Cat.all

    if @cat_rental_request.save
      redirect_to "/cats/cat_id"
    else
      render :new
    end
  end

  def index
    @cat_rental_request = CatRentalRequest.all

    render json: @cat_rental_request
  end

  def approve
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat = Cat.find_by(id: @cat_rental_request.cat_id)

    @cat_rental_request.approve!

    redirect_to cat_url(@cat)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    @cat = Cat.find_by(id: @cat_rental_request.cat_id)

    @cat_rental_request.deny!

    redirect_to cat_url(@cat)
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end