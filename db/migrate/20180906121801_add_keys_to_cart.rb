class AddKeysToCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :user, index: true, foreign_key: true, on_delete: :cascade
    add_reference :carts, :product, index: true, foreign_key: true, on_delete: :cascade
  end
end
