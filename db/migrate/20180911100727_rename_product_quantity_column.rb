class RenameProductQuantityColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :count, :quantity
  end
end
