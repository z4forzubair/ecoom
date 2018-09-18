class Order < ApplicationRecord
  belongs_to :user
  #product_orders
  has_many :product_orders
  has_many :products, through: :product_orders
  # accepts_nested_attributes_for :product_orders

  #Validations
  #total bill is like grand total

end
