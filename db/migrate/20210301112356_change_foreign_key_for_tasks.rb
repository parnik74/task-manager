class ChangeForeignKeyForTasks < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :executor_id, :assignee
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
