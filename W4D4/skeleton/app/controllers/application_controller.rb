class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login(user)
    session[:session_token] = user.session_token
    # redirect_to user_url(user)
  end

  def logout(user)
    if user
      user.reset_session_token!
      session[:session_token] = nil
    end
  end

  def already_logged_in
    if current_user
      flash[:messages] = ["You're already logged in"]
      redirect_to cats_url
    end
  end


end
