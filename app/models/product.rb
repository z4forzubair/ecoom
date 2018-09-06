class Product < ApplicationRecord
  belongs_to :user
  #product_orders
  has_many :product_orders
  has_many :orders, through: :product_orders
  #images
  has_many :images, as: :imageable
  #reviews
  has_many :reviews
  #rating
  has_many :ratings, as: :rated
end
