class RemoveProductUserColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :added_by_user_id
    remove_column :products, :deleted_by_user_id
  end
end
