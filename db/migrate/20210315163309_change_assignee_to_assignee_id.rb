class ChangeAssigneeToAssigneeId < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :assignee, :assignee_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
