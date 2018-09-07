class AddUserProductRef < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :added_by_user, foreign_key: {to_table: :users}, index: true
    add_reference :products, :deleted_by_user, foreign_key: {to_table: :users}, index: true, null: true
  end
end
