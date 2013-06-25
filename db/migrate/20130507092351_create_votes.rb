class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :candidate
      t.float :points
      t.integer :ballot_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
