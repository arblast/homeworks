class CatsController < ApplicationController

  before_action :ensure_cat_owner, only: [:edit, :update]


  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if current_user
      @cat.user_id = current_user.id

      if @cat.save
        redirect_to cat_url(@cat)
      else
        flash.now[:errors] = @cat.errors.full_messages
        render :new
      end
    else
      flash[:messages] = ["Please sign in to create a cat."]
      redirect_to new_session_url
    end

  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def ensure_cat_owner
    unless current_user.cats.any? { |user_cat| params[:id].to_i == user_cat.id }
      flash[:messages] = ["YOU DON'T OWN THE CAT."]
      redirect_to cats_url
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
