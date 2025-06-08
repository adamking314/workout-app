class AddBlocksToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :blocks, :json
  end
end
