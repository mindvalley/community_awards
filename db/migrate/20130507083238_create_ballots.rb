class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.integer :employee_id
      t.float :adjustment_factor, :default=>1.00
      t.string :period

      t.timestamps
    end
  end
end
