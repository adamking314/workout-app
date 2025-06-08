# app/controllers/api/saved_workouts_controller.rb
module Api
  class SavedWorkoutsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :destroy]
    before_action     :require_logged_in_user

    def index
      saved = current_user.saved_workouts.includes(:workout)
      render json: saved.map { |join|
        w = join.workout
        {
          id:           w.id,
          join_id:      join.id,
          workout_name: w.workout_name,
          description:  w.description,
          blocks:       w.blocks
        }
      }
    end

    def create
      workout = Workout.find_by(id: params[:workout_id])
      return render json: { error: "Workout not found" }, status: :not_found unless workout

      if current_user.saved_workouts.exists?(workout_id: workout.id)
        return render json: { error: "Already saved" }, status: :unprocessable_entity
      end

      saved = current_user.saved_workouts.build(workout: workout)
      if saved.save
        render json: { join_id: saved.id, workout_id: workout.id }, status: :created
      else
        render json: { errors: saved.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      saved = current_user.saved_workouts.find_by(id: params[:id])
      return render json: { error: "Not found or not yours" }, status: :not_found unless saved

      saved.destroy
      head :no_content
    end

    private

    def require_logged_in_user
      render(json: { error: "Must be logged in" }, status: :unauthorized) unless current_user
    end

    # ← read from Rails session
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
