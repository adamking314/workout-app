module Api
  class WorkoutsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # If you want to ensure a user is logged in before certain actions:
    before_action :require_login, only: [:create, :update, :destroy]

    # GET /api/workouts
    def index
      # Return all workouts, or filter by username:
      if params[:username]
        @workouts = Workout.where(username: params[:username])
      else
        @workouts = Workout.all
      end
      render json: @workouts
    end

    # GET /api/workouts/:id
    def show
      @workout = Workout.find_by(id: params[:id])
      if @workout
        render json: @workout
      else
        render json: { error: "Workout not found" }, status: :not_found
      end
    end

    # POST /api/workouts
    def create
      # If you want to tie to the logged-in user:
      # current_user.username (assuming you have a current_user helper)
      workout_data = workout_params.merge(username: current_user.username)
      @workout = Workout.new(workout_data)

      if @workout.save
        render json: @workout, status: :created
      else
        render json: { errors: @workout.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/workouts/:id
    def update
      @workout = Workout.find_by(id: params[:id])
      return render json: { error: "Workout not found" }, status: :not_found unless @workout

      # Optional: ensure only owner can update
      if @workout.username != current_user.username
        return render json: { error: "Forbidden" }, status: :forbidden
      end

      if @workout.update(workout_params)
        render json: @workout
      else
        render json: { errors: @workout.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /api/workouts/:id
    def destroy
      @workout = Workout.find_by(id: params[:id])
      return render json: { error: "Workout not found" }, status: :not_found unless @workout

      # Optional: ensure only owner can delete
      if @workout.username != current_user.username
        return render json: { error: "Forbidden" }, status: :forbidden
      end

      @workout.destroy
      render json: { message: "Workout deleted" }
    end

    private

    def workout_params
      params.require(:workout).permit(
        :workout_name,
        :description,
        :block_name,
        :exercise,
        :sets,
        :reps,
        :weight,
        :percent_of_max
      )
    end

    # Simple helper to fetch the logged-in user (using session)
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def require_login
      return if current_user

      render json: { error: "Must be logged in" }, status: :unauthorized
    end
  end
end
