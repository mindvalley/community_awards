class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :period
      t.hstore :lines

      t.timestamps
    end
  end
end
