class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end
  helper_method :current_user

  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = 'You must sign up or sign in first'
      redirect_to new_session_path
    end
  end
end
