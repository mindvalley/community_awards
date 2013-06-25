class AddIndexToResults < ActiveRecord::Migration
  def change
  	add_hstore_index :results, :lines
  end
end
