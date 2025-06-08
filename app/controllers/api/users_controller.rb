module Api
  class UsersController < ApplicationController
    # If you want to skip CSRF for JSON APIs:
    skip_before_action :verify_authenticity_token

    # POST /api/users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: { id: @user.id, username: @user.username, email: @user.email }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end


    # GET /api/users/:id   
    def show
      @user = User.find_by(id: params[:id])
      if @user
        render json: { id: @user.id, username: @user.username }
      else
        render json: { error: "User not found" }, status: :not_found
      end
    end

    private

    def user_params
      # Permit both username and email, plus password
      params.require(:user).permit(:username, :email, :password)
    end
  end
end
