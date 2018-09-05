class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :address
      t.string :contact_number
      t.binary :photo
      t.string :user_role
      t.boolean :flag

      t.timestamps
    end
  end
end
