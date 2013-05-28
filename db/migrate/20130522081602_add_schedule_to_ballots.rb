class AddScheduleToBallots < ActiveRecord::Migration
  def change
    add_column :ballots, :schedule, :text
  end
end
