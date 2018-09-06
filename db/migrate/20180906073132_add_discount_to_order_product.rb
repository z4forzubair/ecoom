class AddDiscountToOrderProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :discount, :integer
    add_column :product_orders, :discount, :integer
    add_column :orders, :total_discount, :integer
  end
end
