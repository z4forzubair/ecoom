class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :no_of_products

      t.timestamps
    end
  end
end
