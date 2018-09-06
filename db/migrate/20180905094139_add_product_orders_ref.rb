class AddProductOrdersRef < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_orders, :order, index: true, foreign_key: true
    add_reference :product_orders, :product, index: true, foreign_key: true
  end
end
