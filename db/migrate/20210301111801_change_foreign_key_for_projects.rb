class ChangeForeignKeyForProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :executor_id, :owner
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
