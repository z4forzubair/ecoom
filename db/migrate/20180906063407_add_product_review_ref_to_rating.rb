class AddProductReviewRefToRating < ActiveRecord::Migration[5.2]
  def change
    add_reference :ratings, :rated, polymorphic: true, index: true
  end
end
