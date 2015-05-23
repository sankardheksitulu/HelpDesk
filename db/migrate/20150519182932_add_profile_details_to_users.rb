class AddProfileDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :avenue_name, :string
    add_column :users, :building_number, :string
    add_column :users, :flat_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :otp, :integer
  end
end
