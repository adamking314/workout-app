module Api
  class WorkoutsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :require_login, only: [:create, :update, :destroy]

    def user_workouts
      user = User.find_by(username: params[:username])
      if user
        @workouts = Workout.where(username: user.username)
        render 'api/workouts/index'
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end

    def index
      @workouts =
        if params[:username]
          Workout.where(username: params[:username])
        else
          Workout.all
        end
      render json: @workouts
    end

    def show
      @workout = Workout.find_by(id: params[:id])
      if @workout
        render json: @workout
      else
        render json: { error: "Workout not found" }, status: :not_found
      end
    end

    def create
      # Merge in the current_user’s username
      workout_data = workout_params.merge(username: current_user.username)
      @workout = Workout.new(workout_data)

      if @workout.save
        render json: @workout, status: :created
      else
        render json: { errors: @workout.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      @workout = Workout.find_by(id: params[:id])
      return render json: { error: "Workout not found" }, status: :not_found unless @workout

      if @workout.username != current_user.username
        return render json: { error: "Forbidden" }, status: :forbidden
      end

      if @workout.update(workout_params)
        render json: @workout
      else
        render json: { errors: @workout.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @workout = Workout.find_by(id: params[:id])
      return render json: { error: "Workout not found" }, status: :not_found unless @workout

      if @workout.username != current_user.username
        return render json: { error: "Forbidden" }, status: :forbidden
      end

      @workout.destroy
      render json: { message: "Workout deleted" }
    end

    private

    def workout_params
      # Permit nested blocks + exercises structure:
      params.require(:workout).permit(
        :workout_name,
        :description,
        :percent_of_max,
        blocks: [
          :name,
          { exercises: [:name, :sets, :reps, :weight] }
        ]
      )
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def require_login
      return if current_user

      render json: { error: "Must be logged in" }, status: :unauthorized
    end
  end
end
