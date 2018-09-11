class AddDiscountDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :discount, :integer, default: 0
  end
end
