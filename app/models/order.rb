class Order < ApplicationRecord
  belongs_to :user
  #product_orders
  has_many :product_orders
  has_many :products, through: :product_orders
  #Validations
  
end
