class ChangeOwnerToOwnerId < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :owner, :owner_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
