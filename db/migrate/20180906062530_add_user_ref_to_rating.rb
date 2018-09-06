class AddUserRefToRating < ActiveRecord::Migration[5.2]
  def change
    add_reference :ratings, :user, index: true, foreign_key: true
  end
end
