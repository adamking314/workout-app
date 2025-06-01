class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all.order(created_at: :desc)
  end

  def show
    @workout = Workout.find_by(id: params[:id])
    return redirect_to workouts_path, alert: "Workout not found" unless @workout
  end
end
