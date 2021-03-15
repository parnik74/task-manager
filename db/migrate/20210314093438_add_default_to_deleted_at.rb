class AddDefaultToDeletedAt < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :deleted_at, :datetime, :default => 'false'
    #Ex:- :default =>''
    #Ex:- :default =>'', :column_options
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
