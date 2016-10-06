class CatRentalRequestsController < ApplicationController

  before_action :ensure_cat_owner, only: [:approve, :deny]


  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    if current_user
      @rental_request.user_id = current_user.id

      if @rental_request.save
        redirect_to cat_url(@rental_request.cat)
      else
        flash.now[:errors] = @rental_request.errors.full_messages
        render :new
      end
      
    else
      flash[:messages] = ["You need to be logged in to make a request"]
      redirect_to cat_url(@rental_request.cat)
    end
  end

  def ensure_cat_owner
    unless current_user.cats.any? { |user_cat| current_cat_rental_request.cat_id.to_i == user_cat.id }
      flash[:messages] = ["YOU DON'T OWN THE CAT."]
      redirect_to cats_url
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private
  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status)
  end
end
