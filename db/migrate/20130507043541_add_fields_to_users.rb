class AddFieldsToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :auth_hash, :string
  	add_column :users, :provider, :string
  	add_column :users, :uid, :string
  	add_column :users, :info, :string
  	add_column :users, :credentials, :string
  	add_column :users, :extra, :string
  end

  def down
  	remove_column :users, :auth_hash
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :info
    remove_column :users, :credentials
    remove_column :users, :extra
  end
end
