class AddProductUserRefToReview < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :user, index: true, foreign_key: true
    add_reference :reviews, :product, index: true, foreign_key: true
  end
end
