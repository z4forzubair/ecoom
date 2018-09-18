class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :quantity, presence: true
  # after_validation :verify_quantity, on: [:create, :update, :save]

  # private
  #To vefiry that the total quantity present in the cart must be less that that of the quantity in product table
  # def verify_quantity

  # end

end
