# app/controllers/api/sessions_controller.rb
module Api
  class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # POST /api/sessions
    def create
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
        # ← set Rails session!
        session[:user_id] = user.id
        render json: { username: user.username }
      else
        render json: { error: "Invalid username or password" }, status: :unauthorized
      end
    end

    # DELETE /api/sessions
    def destroy
      # clear Rails session
      session.delete(:user_id)
      render json: { message: "Logged out" }
    end

    # GET /api/authenticated
    def authenticated
      if session[:user_id] && (user = User.find_by(id: session[:user_id]))
        render json: { username: user.username }
      else
        render json: {}
      end
    end
  end
end
