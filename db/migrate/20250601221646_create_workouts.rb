class CreateWorkouts < ActiveRecord::Migration[8.0]
  def change
    create_table :workouts do |t|
      t.string :username, null: false, index: true
      t.string :workout_name, null: false
      t.text :description
      t.string :block_name
      t.string :exercise
      t.integer :sets
      t.integer :reps
      t.decimal :weight
      t.decimal :percent_of_max

      t.timestamps
    end
  end
end
