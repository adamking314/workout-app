class CreateSavedWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_workouts do |t|
      t.references :user,    null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.timestamps
    end
    add_index :saved_workouts, [:user_id, :workout_id], unique: true
  end
end
