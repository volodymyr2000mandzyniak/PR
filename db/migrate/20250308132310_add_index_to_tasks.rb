class AddIndexToTasks < ActiveRecord::Migration[7.2]
  def change
    add_index :tasks, :status
  end
end
