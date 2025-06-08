class PagesController < ApplicationController
   def home
    # Grab every workout (you could also scope to recent / limit / paginate, etc.)
    @workouts = Workout.all.order(created_at: :desc)
  end

  def profile
     # load all workouts for the “Saved Workouts” grid
    @saved_workouts = Workout.all.order(created_at: :desc)

    # load all workouts again so we can filter “Your Created Workouts” by username
    # (the view’s JS will pick out which ones match current user)
    @created_workouts = Workout.all.order(created_at: :desc)
  end
end
