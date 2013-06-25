class AddValueIdToBallots < ActiveRecord::Migration
  def change
    add_column :ballots, :value_id, :integer
  end
end
