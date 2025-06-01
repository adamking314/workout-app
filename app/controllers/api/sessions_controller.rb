module Api
  class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # POST /api/sessions  (log in)
    def create
      @user = User.find_by(username: params[:username])
      # authenticate returns the user if password is correct, otherwise false
      if @user&.authenticate(params[:password])
        # Here you can set a session token or JWT; for simplicity, we’ll use Rails session
        session[:user_id] = @user.id
        render json: { username: @user.username, id: @user.id }
      else
        render json: { error: "Invalid username or password" }, status: :unauthorized
      end
    end

    # DELETE /api/sessions/:id  (log out) — frontend can send current user’s id or ignore :id
    def destroy
      session.delete(:user_id)
      render json: { message: "Logged out" }
    end
  end
end
