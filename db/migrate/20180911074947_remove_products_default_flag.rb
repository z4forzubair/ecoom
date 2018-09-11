class RemoveProductsDefaultFlag < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:products, :flag, nil)
  end
end
