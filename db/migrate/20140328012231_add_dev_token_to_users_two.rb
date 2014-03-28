class AddDevTokenToUsersTwo < ActiveRecord::Migration
  def change
	  add_column :users, :developer, :boolean
  end
end
