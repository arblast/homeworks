class SessionsController < ApplicationController

before_action :already_logged_in, only: [:new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:user_name], session_params[:password])
    if user
      login(user)
      flash[:messages] = ["Login success"]
      redirect_to cats_url
    else
      flash[:messages] = ["Invald credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    logout(current_user)
    flash[:messages] = ["Logged out"]
    redirect_to new_session_url
  end

  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
