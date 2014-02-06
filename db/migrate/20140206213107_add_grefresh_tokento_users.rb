class AddGrefreshTokentoUsers < ActiveRecord::Migration
  def change
     add_column :users, :grefresh_token, :string
  end
end
