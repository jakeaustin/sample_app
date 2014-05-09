class FixcolName < ActiveRecord::Migration
  def change
  	rename_column :matches, :title, :matchTitle
  end
end
