class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :text
    add_column :users, :contact_number, :string
    add_column :users, :user_role, :string
    add_column :users, :flag, :boolean
  end
end
