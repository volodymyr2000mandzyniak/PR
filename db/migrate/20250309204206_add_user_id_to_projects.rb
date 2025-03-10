class AddUserIdToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :user_id, :bigint
  end
end
