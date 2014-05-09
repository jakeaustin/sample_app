class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
	t.string :title
	t.string :Lpic
	t.string :Ltitle
	t.string :Rpic
	t.string :Rtitle
	t.integer :Lvotes
	t.integer :Rvotes
	t.boolean :approved
      t.timestamps
    end
  end
end
