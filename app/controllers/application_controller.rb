class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Please log in first' }
        format.json { render json: { error: 'Must be logged in' }, status: :unauthorized }
      end
    end
  end
end