class AddTotalBillToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total_bill, :integer
  end
end
