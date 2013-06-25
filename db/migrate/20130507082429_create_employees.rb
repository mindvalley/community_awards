class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :email
      t.date :date_joined
      t.date :start_date
      t.boolean :voteable, :default=>true
      t.string :team
      t.string :status
      t.string :nick_name
      t.string :full_legal_name

      t.timestamps
    end
  end
end
