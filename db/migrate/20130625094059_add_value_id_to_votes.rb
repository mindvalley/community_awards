class AddValueIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :value_id, :integer
  end
end
